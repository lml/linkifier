require "linkifier/engine"

module Linkifier
  # Attributes

  # Can be set in initializer only
  ENGINE_ATTRIBUTES = [
    :linkify_url,
    :authentication_token
  ]

  # Can be set in initializer or passed as an option to linkify method
  LINKIFY_ATTRIBUTES = [
    :name_proc,
    :url_proc,
    :permalink,
    :resource_type,
    :create_proc,
    :destroy_proc,
    :notify_created,
    :notify_destroyed,
    :notify_updated
  ]
  
  (ENGINE_ATTRIBUTES + LINKIFY_ATTRIBUTES).each do |attribute|
    mattr_accessor attribute
  end
  
  def self.configure
    yield self
  end

  def self.is_integer?(str)
    Integer(str) rescue false
  end
end

require "linkifier/linkify"

