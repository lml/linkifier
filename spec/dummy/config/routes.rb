Rails.application.routes.draw do

  mount Linkifier::Engine => "/linkifier"
end
