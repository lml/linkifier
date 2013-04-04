require "linkifier/engine"

module Linkifier
  # Attributes

  # Can be set in initializer only
  ENGINE_ATTRIBUTES = [
  ]

  # Can be set in initializer or passed as an option to linkify method
  LINKIFY_ATTRIBUTES = [
  ]
  
  (ENGINE_ATTRIBUTES + LINKIFY_ATTRIBUTES).each do |attribute|
    mattr_accessor attribute
  end
  
  def self.configure
    yield self
  end

  def linkify_create_resource(r)
    pp 'created' + r
  end

  def linkify_destroy_resource(r)
    pp 'destroyed' + r
  end
end

require "linkifier/linkify"

