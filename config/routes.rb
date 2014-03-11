Ticketee::Application.routes.draw do
  root 'projects#index'

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  namespace :admin do
    root 'base#index'
    resources :users
  end

  resources :projects do
    resources :tickets
  end

  resources :users
end
