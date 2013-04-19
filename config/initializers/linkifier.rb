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

  # Proc that should return a unique name for the resource on Linkify
  # Default: Proc.new { |r| "#{r.class.name} #{r.id}" }
  config.name_proc = Proc.new { |r| "#{r.class.name} #{r.id}" }

  # Proc that should return a unique URL that can be used to access this resource
  # Default: Proc.new { |r| "/#{r.class.name.tableize}/#{r.id}" }
  config.url_proc = Proc.new { |r| "/#{r.class.name.tableize}/#{r.id}" }

  # Whether the above URL is a permanent link
  # Default: false
  config.permalink = false

  # The name or ID of the associated Linkify resource_type
  # Default: "Unknown"
  config.resource_type = "Unknown"

  # If this method returns true, resource should be added to Linkify
  # Otherwise, resource should be removed from Linkify
  # Resources that have been destroyed will always be removed during sync
  # Default: 'persisted?'
  config.persisted_method = 'persisted?'

  # Whether Linkify should be notified whenever this resource is created
  # Default: true
  config.notify_created = true

  # Whether Linkify should be notified whenever this resource is updated
  # Default: false
  config.notify_updated = false

  # Whether Linkify should be notified whenever this resource is destroyed
  # Default: true
  config.notify_destroyed = true
end
