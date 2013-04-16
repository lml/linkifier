class DummyResource < ActiveRecord::Base
  attr_accessible :is_permalink, :name, :resource_type, :url
end
