Rails.application.routes.draw do

  # Routes for the differents home pages
  root "welcomes#index"
  get 'farmer', to: 'welcomes#farmer'
  get 'client', to: 'welcomes#client'

  get 'users/show'

  # Define the resources for chat_rooms
  resources :chat_rooms do
    resources :messages
  end

  # It sets main informations about the user's shopping cart
  get 'cart', to: 'cart#show'
  #get 'cart/add', to: 'cart#add'

  # For adding a product in the shopping cart
  post 'cart/add'

  # For removing a product in the shopping cart
  post 'cart/remove'

  resources :products

  resources :categories
  resources :races

  resources :farmers

  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  get 'user/:id', to: 'users#show', as: 'user'

  get 'welcome/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

end
