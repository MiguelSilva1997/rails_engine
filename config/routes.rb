Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :transactions do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :transactions, only: [:index, :show]do
         resources :invoice, only: [:index], to: 'transactions/invoice#index'
      end

      namespace :invoice_items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :invoice_items, only: [:index, :show] do
        resources :invoice, only: [:index], to: 'invoice_items/invoice#index'
        resources :item, only: [:index], to: 'invoice_items/item#index'
      end

      namespace :invoices do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :invoices, only: [:show, :index] do
        resources :transactions, only: [:index], to: 'invoices/transactions#index'
        resources :merchant, only: [:index], to: 'invoices/merchant#index'
        resources :items, only: [:index], to: 'invoices/items#index'
        resources :customer, only: [:index], to: 'invoices/customer#index'
        resources :invoice_items, only: [:index], to: 'invoices/invoice_items#index'
      end

      namespace :customers do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], to: 'customers/invoices#index'
        resources :transactions, only: [:index], to: 'customers/transactions#index'
        resources :favorite_merchant, only: [:index]
      end

      namespace :items do
        resources :most_items, only: [:index]
        resources :most_revenue, only: [:index]
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :items, only: [:show, :index] do
        resources :best_day, only: [:index]
        resources :invoice_items, only: [:index], to: 'items/invoice_items#index'
        resources :merchant, only: [:index], to: 'items/merchant#index'
      end

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
