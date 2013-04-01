module Linkifier
  module Linkify
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def linkify(name = self.name, options = {})
        class_eval do
          
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Linkifier::Linkify
