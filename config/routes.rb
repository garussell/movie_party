Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'registrations#index'

  resources :welcome, only: [:index]
  resources :users do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show]
    resources :watch_parties, only: %i[new create]
  end

  resources :registrations, only: %i[index new create]

  get "/login", to: "registrations#login_form"
  post "/login", to: "registrations#login"
end
