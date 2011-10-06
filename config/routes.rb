AppealBackend::Application.routes.draw do
  resources :sections do
    resources :topics
  end

  resources :appeals

  root :to => 'appeals#index'
end
