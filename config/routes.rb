Ticketee::Application.routes.draw do
  root 'projects#index'

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "signout", to: "sessions#destroy", as: "signout"

  namespace :admin do
    root 'base#index'
    resources :users do
      resources :permissions
      put "permissions", to: "permissions#set",
                         as: "set_permissions"
    end
    resources "states"
  end

  resources :projects do
    resources :tickets
  end

  resources :tickets do
    resources :comments
  end

  resources :files

  resources :users
end
