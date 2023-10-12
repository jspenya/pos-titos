Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'home#homepage'
  get 'homepage', to: 'home#homepage'
  get 'dashboard', to: 'home#dashboard'
  get '/homepage/:id/add_product', to: 'home#add_product', as: :add_product
  get '/homepage/new_category', to: 'home#new_category', as: :new_category
  get '/homepage/:id', to: 'home#show', as: :show_product
  
  post '/homepage', to: 'home#create_category', as: :categories
  post '/homepage', to: 'home#create_product', as: :create_product
  # Defines the root path route ("/")
  # root "articles#index"
end
