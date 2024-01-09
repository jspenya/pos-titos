Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :user, ->(user) { user.cashier? } do
    root to: 'products#index', as: :cashier_root
  end
  
  devise_for :users
  root "products#index"

  resources :categories do
    resources :products, module: "categories"
  end

  resources :products
end

