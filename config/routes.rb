Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items, only: [:show, :new, :create, :update] do
    collection do
      get 'get_category_child', to: 'items#get_category_child', defaults: { format: 'json' }
      get 'get_category_grandchild', to: 'items#get_category_grandchild', defaults: { format: 'json' }
    end
  end
end
