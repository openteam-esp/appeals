AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :appeals, :only => [:show, :destroy] do
    resource :registration, :only => [:create, :new]
    resource :reply, :only => [:create, :edit, :new, :update]

    member do
      post :revert
      post :close
      post :restore
    end
  end

  namespace :public do
    resources :appeals, :only => [:create, :new, :show]
    resource :check_status, :only => [:create, :new]
    resources :uploads, :only => [:create]
  end

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registered|closed|trash)/ }

  scope :folder => 'fresh' do
    root :to => 'appeals#index'
  end
end
