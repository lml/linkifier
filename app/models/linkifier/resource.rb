require 'net/http'

module Linkifier
  class Resource < ActiveRecord::Base
    attr_accessible :app_resource
    belongs_to :app_resource, :polymorphic => true

    before_validation :create_linkify_resource
    before_destroy :destroy_linkify_resource

    validates_presence_of :linkify_resource_id
    validates_uniqueness_of :app_resource_id, :scope => :app_resource_type, :allow_nil => true
    validates_uniqueness_of :linkify_resource_id

    def self.linkify_resources_url(format = "")
      URI(Linkifier.linkify_url) + ("/resources#{}" + (format.blank? ? "" : ".#{format}"))
    end

    def linkify_resource_url(format = "")
      URI(Linkifier.linkify_url) + ("/resources/#{linkify_resource_id}" + (format.blank? ? "" : ".#{format}"))
    end

    protected

    def create_linkify_resource
      return false if app_resource.nil?
      uri = Resource.linkify_resources_url(:json)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Verify certs

      request = Net::HTTP::Post.new(uri.request_uri)
      resource_type_key = Linkifier.is_integer?(app_resource.linkify_config.resource_type) ? "id" : "name"
      request.set_form_data("auth_token" => Linkifier.authentication_token,
                            "resource[name]" => app_resource.linkify_config.name_proc.call(app_resource),
                            "resource[url]" => app_resource.linkify_config.url_proc.call(app_resource),
                            "resource[is_permalink]" => app_resource.linkify_config.permalink,
                            "resource[resource_type_#{resource_type_key}]" => app_resource.linkify_config.resource_type)

      response = http.request(request)
      return false unless response.kind_of? Net::HTTPSuccess
      json_response = ActiveSupport::JSON.decode(response.body)
      self.linkify_resource_id = json_response['id']
      return false if linkify_resource_id.nil?
    end

    def destroy_linkify_resource
      return if linkify_resource_id.nil?
      uri = self.linkify_resource_url(:json)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Verify certs

      request = Net::HTTP::Delete.new(uri.request_uri)
      request.set_form_data(:auth_token => Linkifier.authentication_token)

      response = http.request(request)
      return false unless response.kind_of? Net::HTTPSuccess
      self.linkify_resource_id = nil
    end
  end
end

