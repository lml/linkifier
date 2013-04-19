require 'linkifier/requests'

module Linkifier
  class Resource < ActiveRecord::Base
    attr_accessible :app_resource
    belongs_to :app_resource, :polymorphic => true

    before_validation :create_linkify_resource
    before_destroy :destroy_linkify_resource

    validates_presence_of :linkify_resource_id
    validates_uniqueness_of :app_resource_id, :scope => :app_resource_type, :allow_nil => true
    validates_uniqueness_of :linkify_resource_id

    protected

    def create_linkify_resource
      return false if app_resource.nil?
      response = Requests.create_linkify_resource(app_resource)
      return false unless response
      json_response = ActiveSupport::JSON.decode(response.body)
      self.linkify_resource_id = json_response['id']
      return false if linkify_resource_id.nil?
    end

    def destroy_linkify_resource
      return if linkify_resource_id.nil?
      response = Requests.destroy_linkify_resource(linkify_resource_id)
      return false unless response
      self.linkify_resource_id = nil
    end
  end
end

