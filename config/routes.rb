Rails.application.routes.draw do
  root to: 'lists#index'

  get  'signup' => 'users#new'
  get  'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :lists do
    member do
      patch 'share'
    end

    resources :tasks, except: [:show] do
      patch '/', action: :update_all, on: :collection
      get ':type', action: :index,
                   on: :collection,
                   as: :filtered,
                   constraints: { type: /open|done/ }
      collection do
        get 'remove_completed'
        patch 'update_all'
      end
    end
  end

  resources :users
  resources :sessions
  resources :password_resets
end
