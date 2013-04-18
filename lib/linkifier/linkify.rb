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
          before_destroy :destroy_linkifier_resource

          protected

          def create_linkifier_resource
            return if !linkify_config.notify_created || !linkify_config.create_iif.call(self)
            linkifier_resource = Linkifier::Resource.create(:app_resource => self)
          end

          def destroy_linkifier_resource
            return if linkifier_resource.nil? || !linkify_config.notify_destroyed || !linkify_config.destroy_iif.call(self)
            linkifier_resource.destroy
          end

          def update_linkifier_resource
            return if !linkifier_resource.nil? || !linkify_config.notify_updated || !linkify_config.create_iif.call(self)
            linkifier_resource = Linkifier::Resource.create(:app_resource => self)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Linkifier::Linkify
