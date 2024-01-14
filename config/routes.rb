Rails.application.routes.draw do
  get 'users/show'

  # Define the resources for chat_rooms
  resources :chat_rooms do
    resources :messages
  end

  get 'cart', to: 'cart#show'
  #get 'cart/add', to: 'cart#add'
  post 'cart/add'
  post 'cart/remove'

  resources :products

  resources :categories
  resources :races

  root "welcomes#index"

  resources :farmers

  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }

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
