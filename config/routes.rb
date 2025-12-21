Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
  resources :users
  resources :suppliers
  resources :brands
  resources :products
  resources :purchase_orders
  resources :sales_orders
  resources :inventories

  get "browserconfig", to: "home#browserconfig", constraints: lambda { |req| req.format == :xml }, as: "browserconfig"
  get "site", to: "home#site", constraints: lambda { |req| req.format == :webmanifest }, as: "webmanifest"

  # error pages
  %w(400 403 404 405 406 409 422 500 501).each do |code|
    get code, to: "exceptions#index", defaults: { code: }
  end

  devise_for :users,
    path: "",
    controllers: {
      sessions: "users/sessions",
      passwords: "users/passwords"
    },
    path_names: {
      sign_in: "/login",
      password: "/forgot",
      sign_out: "/logout"
    }
end
