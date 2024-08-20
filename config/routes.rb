Rails.application.routes.draw do
  namespace :payments do
    post "callback" => "callback#create"
  end
  namespace :dashboard do
    root "home#index"
  end
  namespace :app do
    get "/" => "notices#index"
    resources :notices, only: %i[show]
  end
  resources :notices
  resources :notices do
    resource :notice_images, only: %i[new create]
    post "payment" => "payment#create"
  end

  delete "attachments/:id" => "attachments#destroy", :as => :destroy_attachment

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "home#index"
end
