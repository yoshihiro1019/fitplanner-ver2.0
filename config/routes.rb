Rails.application.routes.draw do
  get "training_proposals/index"
  get "training_proposals/new"
  get "training_proposals/create"
  # Devise routes with OmniAuth callbacks
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    passwords: "password_resets"
  }

  # Custom route for mypage
  resource :mypage, only: [ :show ], controller: "mypages"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA-related routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "privacy_policy", to: "static_pages#privacy_policy", as: "privacy_policy"
  # Custom routes
  get "gym_search", to: "gyms#index", as: :gym_search
  get "bgm", to: "bgm#index", as: :bgm
  get "/terms", to: "pages#terms"
  get "/callback", to: "callbacks#callback"

  # Root route
  root "tasks#index"
  get "/playlists", to: "playlists#index"

  # Resource routes
  resources :questions
  resources :tasks
  resources :training_logs, only: [ :new, :create, :index, :edit, :update, :destroy ]

  # ↓ここを変更
  resources :training_suggestions, only: [ :index, :new, :create ]
  # ↑ 'index' を追加する
  resources :training_proposals, only: [ :index, :new, :create ] do
    collection do
      get :history  # GET /training_proposals/history → training_proposals#history
    end
  end
  # Password reset routes
  resource :password_reset, only: [ :new, :create ]
  devise_scope :user do
    get "password_resets/edit_direct", to: "password_resets#edit_direct", as: :edit_direct_password
    put "password_resets/update_direct", to: "password_resets#update_direct", as: :update_direct_password
  end
end
