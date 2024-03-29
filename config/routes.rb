Rails.application.routes.draw do
  get 'customer_order/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :user, ->(user) { user.cashier? } do
    root to: 'customer_orders#tables', as: :cashier_root
  end

  authenticated :user, ->(user) { user.stockman? } do
    root to: 'stocks#index', as: :stockman_root
  end

  devise_for :users
  root "products#index"

  resources :orders do
    resources :products, module: :orders
    resources :order_items, module: :orders
  end
  resources :categories do
    resources :products, module: :categories
  end

  resources :products
  resources :customers, module: :customers do
    resources :orders, except: :destroy do
      resources :order_items, module: :orders
    end
  end

  resources :payments
  resources :stocks
  resources :stock_versions
  resources :charts do
    collection do
      get :sales_all_time
      get :products_sold
      get :products_sold_this_week
      get :orders
      get :order_types
    end
  end

  get "sales", to: "payments#index"
  get "customer_orders/tables", to: "customer_orders#tables"
  get "customer_orders/individual_orders", to: "customer_orders#individual_orders"
end

