Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        collection do
          get '/find_all', to: 'merchants/search#index'
          get '/find', to: 'merchants/search#show'
          get '/random', to: 'merchants/random#show'
        end
      end
    end
  end
end
