AppealBackend::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :appeals, :only => [:show, :destroy] do
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

  post 'replies/:reply_id/upload' => 'uploads#create', :as => 'reply_uploads'
  resources :uploads, :only => :destroy

  namespace :public do
    resources :appeals, :only => [:create, :new, :show]
    resource :check_status, :only => [:create, :new]
    resources :uploads, :only => [:create, :destroy]
  end

  get '/uploads/:id/*file_name' => Dragonfly[:uploads].endpoint { |params, app |
    app.fetch Upload.where(:file_name => params[:file_name]).find(params[:id]).file_uid
  }, :as => :upload, :format => false

  get '/:folder/appeals' => 'appeals#index',
      :as => :scoped_appeals,
      :constraints => { :folder => /(fresh|registered|noted|redirected|reviewing|closed|trash)/ }

  scope :folder => 'fresh' do
    root :to => 'appeals#index'
  end
end
