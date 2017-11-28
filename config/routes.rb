Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_revenue, only: [:index]
        resources :revenue, only: [:index]
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        resources :most_items, only: [:index]
      end

    resources :merchants, only: [:show, :index] do
       resources :items, only: [:index], to: 'merchants/items#index'
       resources :invoices, only: [:index], to: 'merchants/invoices#index'
       resources :revenue, only: [:index]
       resources :favorite_customer, only: [:index]
    end
    end
  end
end
