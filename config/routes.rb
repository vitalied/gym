Rails.application.routes.draw do
  namespace :trainer do
    resources :trainees, only: :index
    resources :workouts do
      member do
        put :assign_trainee
      end
    end
  end

  namespace :trainee do
    resources :trainees, only: [] do
      collection do
        post :select_trainer
      end
    end
    resources :workouts, only: :index
  end

  # this needs to go last!
  match '/:anything', to: 'application_public#routing_error', constraints: { anything: /.*/ }, via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
