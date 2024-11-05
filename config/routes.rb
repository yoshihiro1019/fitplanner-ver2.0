Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "bgm/index"
  get "trainings/index"
  get "gyms/index"
  get "training_logs/index"
  devise_for :users
  get "mypages/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get 'training_logs', to: 'training_logs#index', as: :training_logs
  get 'gym_search', to: 'gyms#index', as: :gym_search
  get 'training_suggestions', to: 'training_suggestions#new', as: :training_suggestions
  get 'bgm', to: 'bgm#index', as: :bgm
  # Root route
  root "tasks#index"
  resources :questions
  # Resources for tasks
  resources :tasks
  resources :training_logs, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :training_suggestions, only: [:new, :create, :index]
  # Route for mypage (マイページ)
  resource :mypage, only: [ :show ], controller: "mypages"
  resource :password_reset, only: [:new, :create]
end
