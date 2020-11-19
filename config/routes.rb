Rails.application.routes.draw do

  devise_for :users, controllers:{
    registrations: 'users/registrations',
    # sessions: 'users/sessions',
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
    # get "sign_in", to: "users/sessions#new"
    # get "sign_out", to: "users/sessions#destroy" 
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'items#index'
  get 'items/sell'
  get 'items/buy'

  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'sell'
    end
    member do
      get 'buy'
      post 'pay'
      get 'pay'
      get 'done'
    end
  end

  get 'users/logout'

  resources :creditcard, only: [:new, :show] do
    collection do
      post 'show', to: 'creditcard#show'
      post 'pay', to: 'creditcard#pay'
      post 'delete', to: 'creditcard#delete'
    end
  end  

  resources :users, only: [:show, :destroy] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :categories, only: [:index, :show]
end
