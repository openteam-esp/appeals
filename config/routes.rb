Appeals::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :appeals, :only => [:show, :destroy] do
      get '/:folder/appeals' => 'appeals#index',
          :constraints => { :folder => /(fresh|registered|noted|redirected|reviewing|closed|trash)/ },
          :as => :scoped_appeals

      get '/:print' => 'appeals#show',
          :constraints => { :print => /print/ },
          :on => :member,
          :as => :print_version

      member do
        post :close
        post :restore
        post :revert
      end

      post 'replies/:reply_id/uploads' => 'uploads#create', :as => :reply_uploads

      resource :note,         :only => [:create, :new]
      resource :redirect,     :only => [:create, :new]
      resource :registration, :only => [:create, :new]
      resource :review,       :only => [:create, :new]
      resource :reply,        :only => [:create, :edit, :new, :update]
    end

    scope :folder => 'fresh' do
      root :to => 'appeals#index'
    end
  end

  resource :check_status, :only => [:create, :new]

  resources :sections, :only => [], :shallow => true do
    resources :appeals, :only => [:create, :new, :show]
  end

  root :to => 'home#show'
end
