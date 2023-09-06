# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'registrations#index'

  get '/login', to: 'registrations#login_form'
  post '/login', to: 'registrations#login'
  delete '/logout', to: 'registrations#logout'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

  resources :welcome, only: [:index]
  
  resources :users do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show]
    resources :watch_parties, only: %i[new create]
  end

  resources :registrations, only: %i[index new create]


end
