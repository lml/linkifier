require 'net/http'

module Linkifier
  class Resource < ActiveRecord::Base
    attr_accessible :app_resource, :linkify_resource_id
    belongs_to :app_resource, :polymorphic => true

    before_validation :create_linkify_resource
    before_destroy :destroy_linkify_resource

    validates_presence_of :linkify_resource_id

    protected

    def create_linkify_resource
      return false if app_resource.nil?
      uri = URI(Linkifier.linkify_url) + "resources.json"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Certs

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data('auth_token' => Linkifier.authentication_token,
                            'resource[name]' => app_resource.linkify_config.name_proc.call(app_resource),
                            'resource[url]' => app_resource.linkify_config.url_proc.call(app_resource),
                            'resource[is_permalink]' => app_resource.linkify_config.permalink,
                            'resource[resource_type]' => app_resource.linkify_config.type)

      response = http.request(request)
      return false unless response.kind_of? Net::HTTPSuccess
      json_response = ActiveSupport::JSON.decode(response.body)
      linkify_resource_id = json_response['id']
      return false if linkify_resource_id.nil?
    end

    def destroy_linkify_resource
      return if linkify_resource_id.nil?
      uri = URI(Linkifier.linkify_url) + "resources/#{linkify_resource_id}.json"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # TODO: Certs

      request = Net::HTTP::Delete.new(uri.request_uri)
      request.set_form_data(:auth_token => Linkifier.authentication_token)

      response = http.request(request)
      return false unless response.kind_of? Net::HTTPSuccess
      linkify_resource_id = nil
    end
  end
end

