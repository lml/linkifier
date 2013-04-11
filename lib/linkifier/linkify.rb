module Linkifier
  module Linkify
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def linkify(options = {})
        class_eval do
          cattr_accessor :linkify_config
          self.linkify_config = Linkifier::LinkifyConfig.new(options)

          has_one :linkify_resource

          after_create :create_linkify_resource
          after_update :update_linkify_resource
          before_destroy :destroy_linkify_resource

          protected

          def create_linkify_resource
            return if !linkify_config.notify_created || !linkify_config.create_iif.call(self)
            linkify_resource = LinkifyResource.create(:resource => self)
          end

          def destroy_linkify_resource
            return if linkify_resource.nil? || !linkify_config.notify_destroyed || !linkify_config.destroy_iif.call(self)
            linkify_resource.destroy
          end

          def update_linkify_resource
            return if !linkify_resource.nil? || !linkify_config.notify_updated || !linkify_config.create_iif.call(self)
            linkify_resource = LinkifyResource.create(:resource => self)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Linkifier::Linkify
