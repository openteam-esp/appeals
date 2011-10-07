AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :appeals, :only => :show do
    resource :registration, :only => [:create, :edit, :new, :update]

    post :revert, :on => :member
  end

  namespace :public do
    resources :appeals, :only => [:create, :new, :show]
  end

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registred|replied)/ }

  root :to => 'appeals#index'
end
