BicycleCms::Engine.routes.draw do

  # TODO I18n
  #  localized(I18n.available_locales, verbose: true) do

    root *BicycleCms.root_route

    get :admin_panel, to: 'system_pages#admin_panel'

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

    resources :feedbacks, except: [:edit, :update]

    resources :mailings, except: [:edit, :update]

    get '/profile' => 'users#profile',        as: :profile
    get '/profile/edit' => 'users#edit_profile',   as: :edit_profile
    put '/profile' => 'users#update_profile', as: :update_profile

    get '/feedback' => 'feedbacks#new'
    post '/feedback' => 'feedbacks#create'

    resource :order, only: [:show, :new, :create, :destroy] do
      post   'add'        => 'orders#add',    as: :add_to
      put    'update/:id' => 'orders#update', as: :update
      delete 'delete/:id' => 'orders#delete', as: :delete_from
      delete 'delete_product_inclusions/:id' => 'orders#delete_product_inclusions', as: :delete_product_inclusions_from
    end

  #  end

end
