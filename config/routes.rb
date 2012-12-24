BicycleCms::Engine.routes.draw do

  # TODO I18n
  #  localized(I18n.available_locales, verbose: true) do

    root configatron.route_root_to

    get :admin_panel, to: 'system_articles#admin_panel'

    resources :articles, except: :index do
      resources :comments
    end

    resources :events do
      resources :comments
    end

    resources :comments do
      get :all, on: :collection
    end

    resources :categories do
      get :tree, on: :member
    end

    devise_for :users, class_name: 'BicycleCms::User', module: 'devise'

    resources :users

    # resource :feedback, only: [:new, :create] # TODO Зачем это?
    resources :feedbacks, except: [:edit, :update]

    resources :mailings, except: [:edit, :update]

    get '/profile' => 'users#profile',        as: :profile
    get '/profile/edit' => 'users#edit_profile',   as: :edit_profile
    put '/profile' => 'users#update_profile', as: :update_profile

    get '/feedback' => 'feedbacks#new'
    post '/feedback' => 'feedbacks#create'

    resource :order, only: [:index, :new, :create] do
      get '' => 'orders#show', as: :show
      post 'add' => 'orders#add', as: :add_to
      put 'update/:id' => 'orders#update', as: :update
      delete 'delete/:id' => 'orders#destroy', as: :delete_from
      get 'clean' => 'orders#clean', as: :clean
    end

#    get '/*id' => "#{configatron.route_root_requests_to}#show", as: configatron.route_root_requests_to.singularize

  #  end

end
