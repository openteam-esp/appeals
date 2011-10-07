AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :appeals, :only => :show do
    resource :registration, :only => [:create, :new]
  end

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registred|replied)/ }

  root :to => 'appeals#index'
end
