$:.push File.expand_path("../lib", __FILE__)

require "linkifier/version"

Gem::Specification.new do |s|
  s.name        = "linkifier"
  s.version     = Linkifier::VERSION
  s.authors     = ["Dante Soares"]
  s.email       = ["dms3@rice.edu"]
  s.homepage    = "http://github.com/lml/linkifier"
  s.summary     = "Support gem for Linkify."
  s.description = "Enables other rails applications to register Linkify resources and send information about them to Linkify."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "minitest-rails-capybara"
end
