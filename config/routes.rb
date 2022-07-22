# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users, only: %i[create update destroy] do
    get '/me', to: 'users#show'
    post '/sign_in', to: 'users#sign_in'
    post '/sign_out', to: 'users#sign_out'
    get '/audit_logs', to: 'users#audit_logs'

    resources :expenses, only: %i[index show update destroy] do
      get '/audit_logs', to: 'expenses#audit_logs'
    end
  end

  namespace :stripe do
    post '/payments/checkout_completed', to: 'payments#checkout_completed'
    post '/mock/checkout_completed', to: 'mock#checkout_completed'
  end

  namespace :apple_pay do
    post '/payments/payment_completed', to: 'payments#payment_completed'
    post '/mock/payment_completed', to: 'mock#payment_completed'
  end
end
