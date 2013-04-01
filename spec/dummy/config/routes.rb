Rails.application.routes.draw do

  resources :resources


  mount Linkifier::Engine => "/linkifier"
end
