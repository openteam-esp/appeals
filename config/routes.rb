AppealBackend::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  resources :appeals, :only => [:show, :destroy] do
    get '/:print' => 'appeals#show', :constraints => { :print => /print/ }, :on => :member, :as => :print_version
    resource :note,         :only => [:create, :new]
    resource :redirect,     :only => [:create, :new]
    resource :registration, :only => [:create, :new]
    resource :review,       :only => [:create, :new]
    resource :reply,        :only => [:create, :edit, :new, :update]

    member do
      post :close
      post :restore
      post :revert
    end
  end

  post 'replies/:reply_id/uploads' => 'uploads#create', :as => :reply_uploads

  namespace :public do
    resources :sections, :only => [], :shallow => true do
      resources :appeals, :only => [:create, :new, :show]
    end

    resource :check_status, :only => [:create, :new]
  end

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registered|noted|redirected|reviewing|closed|trash)/ }

  scope :folder => 'fresh' do
    root :to => 'appeals#index'
  end
end
