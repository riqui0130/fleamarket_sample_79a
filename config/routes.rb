Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'items#index'
  get 'items/sell'
  get 'items/buy'
  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
  get 'users/logout'
  resources :items, only: [:show, :new]
    resources :items do
      collection do
        get 'buy'
      end
    end
  resources :users, only: :show
end