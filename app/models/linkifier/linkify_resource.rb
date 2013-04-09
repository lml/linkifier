module Linkifier
  class LinkifyResource < ActiveRecord::Base
    attr_accessible :resource, :linkify_resource_id
    belongs_to :resource, :polymorphic => true

    before_validation :linkify_create_resource
    before_destroy :linkify_destroy_resource

    validates_presence_of :resource
    validates_presence_of :linkify_resource_id

    protected

    def linkify_create_resource
      return false if resource.nil?
      pp 'created' + r
      return false if linkify_resource_id.nil?
    end

    def linkify_destroy_resource
      return if linkify_resource_id.nil?
      pp 'destroyed' + r
      return false unless linkify_resource_id.nil?
    end
  end
end
