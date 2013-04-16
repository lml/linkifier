Rails.application.routes.draw do
  resources :dummy_resources


  mount Linkifier::Engine => "/linkifier"
end
