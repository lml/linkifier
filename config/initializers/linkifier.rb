# Change the settings below to suit your needs
# All settings are initially set to their default values
Linkifier.configure do |config|

  # Engine Options (initializer only)

  # Linkify's URL
  # Default: "http://www.linkify.org"
  config.linkify_url = "http://www.linkify.org"

  # Authentication token for this site on Linkify
  # Default: ""
  config.authentication_token = ""



  # Linkify Options (initializer or inline)

  # Name of the resource on Linkify
  # Default: ""
  config.name = ""

  # URL of the resource that Linkify should point to
  # Default: ""
  config.url = ""

  # Whether the above URL is a permalink
  # Default: true
  config.permalink = true

  # The name or ID of the associated Linkify resource_type
  # Default: "Unknown"
  config.type = "Unknown"

  # Resource will only be created in Linkify if this proc returns true
  # Default: Proc.new { |r| true }
  config.create_iif = Proc.new { |r| true }

  # Resource will only be destroyed in Linkify if this proc returns true
  # Default: Proc.new { |r| true }
  config.destroy_iif = Proc.new { |r| true }

  # Whether Linkify should be notified when this resource is created
  # Default: true
  config.notify_created = true

  # Whether Linkify should be notified when this resource is destroyed
  # Default: true
  config.notify_destroyed = true

  # Whether Linkify should be notified when this resource is updated
  # Default: false
  config.notify_updated = false
end
