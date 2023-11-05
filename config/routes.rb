Rails.application.routes.draw do

  devise_for :users
  root "posts#index"
  resources :posts
  
  get "pricing", to: "static_pages#pricing"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
