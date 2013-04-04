module Linkifier
  class LinkifyConfig
    Linkifier::LINKIFY_ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end
  
    def initialize(options = {})
      Linkifier::LINKIFY_ATTRIBUTES.each do |attribute|
        self.send attribute.to_s + '=', options[attribute] || Linkifier.send(attribute)
      end
    end
  end
end
