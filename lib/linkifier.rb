require "linkifier/engine"

module Linkifier
  # Attributes

  # Can be set in initializer only
  ENGINE_ATTRIBUTES = [
    :linkify_url,
    :authentication_token,
    :ca_file_path
  ]

  # Can be set in initializer or passed as an option to linkify method
  LINKIFY_ATTRIBUTES = [
    :name_proc,
    :url_proc,
    :permalink,
    :resource_type,
    :persisted_method,
    :notify_created,
    :notify_destroyed,
    :notify_updated
  ]

  LINKIFIED_CLASSES = []

  CA_FILE_PATH = File.expand_path("../../certs/cacert.pem", __FILE__)
  
  (ENGINE_ATTRIBUTES + LINKIFY_ATTRIBUTES).each do |attribute|
    mattr_accessor attribute
  end
  
  def self.configure
    yield self
  end
end

require "linkifier/linkify"

