Appeals::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    get '/:folder/appeals' => 'appeals#index',
      :constraints => { :folder => /(fresh|registered|noted|redirected|reviewing|closed|trash)/ },
      :as => :scoped_appeals

    resources :kremlin_appeals
    resources :appeals, :only => [:show, :destroy] do

      get '/:print' => 'appeals#show',
          :constraints => { :print => /print/ },
          :on => :member,
          :as => :print_version

      member do
        post :close
        post :restore
        post :revert
      end

      resource :note,         :only => [:create, :new]
      resource :redirect,     :only => [:create, :new]
      resource :registration, :only => [:create, :new]
      resource :review,       :only => [:create, :new]
      resource :reply,        :only => [:create, :edit, :new, :update]
    end

    root :to => 'appeals#index', :folder => 'fresh'
  end

  resource :check_status, :only => [:create, :new]

  resources :sections, :only => [], :shallow => true do
    resources :appeals, :only => [:create, :new, :show]
  end

  # NOTE: наверное потом как-то изменится
  root :to => 'appeals#new', :defaults => { :section_id => 1 }
end
