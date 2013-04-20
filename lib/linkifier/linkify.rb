require "linkifier/linkify_config"

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

          has_one :linkifier_resource, :as => :app_resource, :class_name => 'Linkifier::Resource'

          after_create :create_linkifier_resource
          after_update :update_linkifier_resource
          after_destroy :destroy_linkifier_resource

          protected

          def create_linkifier_resource
            return unless linkify_config.notify_created
            linkifier_resource = Linkifier::Resource.create(:app_resource => self) if self.send(linkify_config.persisted_method)
          end

          def destroy_linkifier_resource
            return unless linkify_config.notify_destroyed
            linkifier_resource.destroy if !linkifier_resource.nil? && !self.send(linkify_config.persisted_method)
          end

          def update_linkifier_resource
            return unless linkify_config.notify_updated
            if linkifier_resource.nil? && self.send(linkify_config.persisted_method)
              linkifier_resource = Linkifier::Resource.create(:app_resource => self)
            elsif !linkifier_resource.nil? && !self.send(linkify_config.persisted_method)
              linkifier_resource.destroy
            end
          end
        end
        Linkifier::LINKIFIED_CLASSES << self
      end

      alias_method :linkifier, :linkify
    end
  end
end

ActiveRecord::Base.send :include, Linkifier::Linkify
