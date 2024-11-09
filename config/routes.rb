Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "bgm/index"
  get "trainings/index"
  get "gyms/index"
  get "training_logs/index"

  # Devise routes with OmniAuth callbacks
  devise_for :users, controllers: { 
    passwords: 'password_resets',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations" # 追加部分
  }

  # Custom route for mypage
  get "mypages/show"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA-related routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Custom routes with named paths
  get 'training_logs', to: 'training_logs#index', as: :training_logs
  get 'gym_search', to: 'gyms#index', as: :gym_search
  get 'training_suggestions', to: 'training_suggestions#new', as: :training_suggestions
  get 'bgm', to: 'bgm#index', as: :bgm

  # Root route
  root "tasks#index"

  # Resource routes
  resources :questions
  resources :tasks
  resources :training_logs, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :training_suggestions, only: [:new, :create, :index]

  # Route for mypage
  resource :mypage, only: [:show], controller: "mypages"

  # Password reset routes
  resource :password_reset, only: [:new, :create]
  devise_scope :user do
    # Add route for direct password edit
    get 'password_resets/edit_direct', to: 'password_resets#edit_direct', as: :edit_direct_password
    put 'password_resets/update_direct', to: 'password_resets#update_direct', as: :update_direct_password
  end
end
