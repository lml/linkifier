module Linkifier
  module Linkify
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def linkify(options = {})
        class_eval do
          cattr_accessor :linkify_resource_name
          cattr_accessor :linkify_resource_url
          cattr_accessor :linkify_resource_permalink
          cattr_accessor :linkify_resource_type
          self.linkify_resource_name = options[:name] || name
          self.linkify_resource_url = options[:url] || ""
          self.linkify_resource_permalink = options[:permalink].nil? ? true : options[:permalink]
          self.linkify_resource_type = options[:resource_type] || ""

          cattr_accessor :linkify_config
          self.linkify_config = Linkifier::LinkifyConfig.new(options)

          after_create :linkify_create_resource
          after_destroy :linkify_destroy_resource

          def linkify_create_resource
            return false unless config.create_iif.call
            return Linkifier.linkify_create_resource(self)
          end

          def linkify_destroy_resource
            return false unless config.create_iif.call
            return Linkifier.linkify_destroy_resource(self)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Linkifier::Linkify
