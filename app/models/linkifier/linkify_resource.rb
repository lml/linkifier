require 'net/http'

uri = URI.parse("https://secure.com/")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
response.body
response.status
response["header-here"] # All headers are lowercase

module Linkifier
  class LinkifyResource < ActiveRecord::Base
    attr_accessible :resource, :linkify_resource_id
    belongs_to :resource, :polymorphic => true

    before_validation :linkify_create_resource
    before_destroy :linkify_destroy_resource

    validates_presence_of :linkify_resource_id

    protected

    def linkify_create_resource
      return false if resource.nil?
      uri = Linkifier.linkify_uri + "resources.json"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Certs

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(:auth_token => Linkifier.authentication_token,
                            :name => resource.linkify_config.name,
                            :url => resource.linkify_config.url,
                            :is_permalink => resource.linkify_config.permalink,
                            :resource_type_id => resource.linkify_config.type)

      response = http.request(request)
      puts response.body
      # TODO: set linkify_resource_id by parsing JSON response
      return false if linkify_resource_id.nil?
    end

    def linkify_destroy_resource
      return if linkify_resource_id.nil?
      uri = Linkifier.linkify_uri + "resources/#{linkify_resource_id}.json"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Certs

      request = Net::HTTP::Delete.new(uri.request_uri)
      request.set_form_data(:auth_token => Linkifier.authentication_token)

      response = http.request(request)
      puts response.body
      linkify_resource_id = nil if response.kind_of? Net::HTTPSuccess
      return false unless linkify_resource_id.nil?
    end
  end
end
