AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :sections do
    resources :topics
  end

  resources :appeals

  root :to => 'appeals#index'
end
