require "linkifier/engine"

module Linkifier
  # Attributes

  # Can be set in initializer only
  ENGINE_ATTRIBUTES = [
    :linkify_url
  ]

  # Can be set in initializer or passed as an option to linkify method
  LINKIFY_ATTRIBUTES = [
    :name,
    :url,
    :permalink,
    :type,
    :create_iif,
    :destroy_iif,
    :notify_create,
    :notify_destroy
  ]
  
  (ENGINE_ATTRIBUTES + LINKIFY_ATTRIBUTES).each do |attribute|
    mattr_accessor attribute
  end
  
  def self.configure
    yield self
  end
end

require "linkifier/linkify"

