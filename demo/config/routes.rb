Rails.application.routes.draw do
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check

  mount Lookbook::Engine, at: "/lookbook"
  root to: redirect("/lookbook")

  # resources :products
  # resources :suggestions, only: :index
  # resource :uploads, only: :create
end
