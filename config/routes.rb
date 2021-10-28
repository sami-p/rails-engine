Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'
      
      resources :merchants, only: [:index, :show] do
        resources :items, module: 'merchant', only: [:index]
      end

      resources :items, except: [:new] do
        get 'merchant', to: 'items/merchant#index'
      end
    end
  end
end
