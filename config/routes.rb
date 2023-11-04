Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root "products#index"

  resources :orders do 
    resources :products
  end
  resources :categories do
    resources :products, module: "categories"
  end

  
  resources :products
end
