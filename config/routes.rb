Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users, only: %i[create update destroy] do
    get '/me', to: 'users#show'
  end
end
