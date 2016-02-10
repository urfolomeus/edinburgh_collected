Rails.application.routes.draw do
  mount Judge::Engine => '/judge'

  get 'about' => 'static#about'
  get 'contact' => 'static#contact'
  get 'p_and_c' => 'static#p_and_c'
  get 't_and_c' => 'static#t_and_c'

  namespace :styleguide do
    get '/' => 'base#index'

    resources :components, only: :index
  end

  namespace :my do
    get '/getting_started' => 'getting_started#index'
    patch '/skip_getting_started' => 'getting_started#skip_getting_started'

    resources :memories do
      collection do
        get 'add_memory'
      end
    end
    resources :scrapbooks do
      member do
        get :view
      end
    end
    resources :scrapbook_memories

    get '/profile' => 'profile#show'
    get '/profile/edit' => 'profile#edit'
    patch '/profile' => 'profile#update'
  end

  resources :memories do
    member do
      get 'report' => 'report/memories#edit'
      put 'report' => 'report/memories#update'
    end
  end

  resources :scrapbooks, only: [:index, :show] do
    member do
      get 'report' => 'report/scrapbooks#edit'
      put 'report' => 'report/scrapbooks#update'
    end
  end

  namespace :search do
    resources :memories, only: [:index]
    resources :scrapbooks, only: [:index]
  end

  namespace :filter do
    get '/area'     => 'area#index'
    get '/category' => 'category#index'
    get '/tag'      => 'tag#index'
  end

  namespace :admin do
    get '/home' => 'home#index'

    namespace :moderation do
      resources :memories, only: [:index, :show] do
        collection do
          get :moderated
          get :reported
        end
        member do
          put :approve
          put :reject
          put :unmoderate
        end
      end

      resources :scrapbooks, only: [:index, :show] do
        collection do
          get :moderated
          get :reported
        end
        member do
          put :approve
          put :reject
          put :unmoderate
        end
      end

      resources :users, only: [:index, :show] do
        collection do
          get :unmoderated
          get :reported
          get :blocked
        end
        member do
          put :approve
          put :block
          put :unblock
          put :reject
          put :unmoderate
        end
      end
    end
  end

  resources :users, only: [:new, :create] do
    resources :memories,   only: [:index], controller: 'users/memories',   action: 'index'
    resources :scrapbooks, only: [:index], controller: 'users/scrapbooks', action: 'index'
    member do
      get :activate
      get 'report' => 'report/users#edit'
      put 'report' => 'report/users#update'
    end
    collection do
      get :resend_activation_email
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  post '/temp_images' => 'temp_images#create'

  get '/400' => 'exceptions#bad_request'
  get '/401' => 'exceptions#not_authorized'
  get '/404' => 'exceptions#not_found'
  get '/422' => 'exceptions#unprocessable_entity'
  get '/500' => 'exceptions#internal_server_error'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
