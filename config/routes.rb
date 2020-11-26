Rails.application.routes.draw do
  # this needs to go last!
  match '/:anything', to: 'application_public#routing_error', constraints: { anything: /.*/ }, via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
