# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users, only: %i[create update destroy] do
    get '/me', to: 'users#show'
    post '/sign_in', to: 'users#sign_in'

    resources :expenses, only: %i[index show update destroy]
  end

  namespace :stripe do
    post '/payments/checkout_completed', to: 'payments#checkout_completed'
    post '/mock/checkout_completed', to: 'mock#checkout_completed'
  end
end
