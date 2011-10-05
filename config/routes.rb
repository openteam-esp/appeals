AppealBackend::Application.routes.draw do
  resources :appeals

  root :to => 'appeals#index'
end
