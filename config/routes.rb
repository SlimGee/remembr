Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/403", to: "errors#forbidden", via: :all
  match "/422", to: "errors#unproccessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match "/501", to: "errors#method_not_allowed", via: :all

  namespace :admin do
    root "home#index"
    resources :posts
  end

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

  resources :posts, only: %i[index show]

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
