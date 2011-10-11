AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :appeals, :only => :show do
    resource :registration, :only => [:create, :new]
    resource :reply, :only => [:create, :edit, :new, :update]

    member do
      post :revert
      post :close
    end
  end

  namespace :public do
    resources :appeals, :only => [:create, :new, :show]
    resource :check_status, :only => [:create, :new]
  end

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registered|closed)/ }

  scope :folder => 'fresh' do
    root :to => 'appeals#index'
  end
end
