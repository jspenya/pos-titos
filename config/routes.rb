Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'home#homepage'
  get 'homepage', to: 'home#homepage'
  get 'dashboard', to: 'home#dashboard'
  get '/homepage/:id', to: 'home#show', as: :show_product
  
  # Defines the root path route ("/")
  # root "articles#index"
end
