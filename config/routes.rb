# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Inline editing для RailsAdmin
  namespace :rails_admin do
    post 'inline_edit/:model_name/:id', to: 'inline_edits#update_field', as: 'inline_edit'
    
    # Statistics API
    get 'statistics/user_registrations', to: 'statistics#user_registrations'
    get 'statistics/projects', to: 'statistics#projects'
    get 'statistics/revenue', to: 'statistics#revenue'
    get 'statistics/activity', to: 'statistics#activity'
    get 'statistics/conversion', to: 'statistics#conversion'
    get 'statistics/token_packages', to: 'statistics#token_packages'
    get 'statistics/styles', to: 'statistics#styles'
    get 'statistics/top_users', to: 'statistics#top_users'
    
    # Reports
    get 'reports/financial', to: 'reports#financial_report'
    get 'reports/user_activity', to: 'reports#user_activity_report'
    get 'reports/generation', to: 'reports#generation_report'
  end
  # Landing page
  get "landing/index"
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Root route - MUST be defined
  root "landing#index"
  
  # Devise routes with custom controllers
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  
  # Letter opener web (для просмотра писем в development)
  if Rails.env.development? && defined?(LetterOpenerWeb)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # Dashboard routes
  get "dashboard", to: "dashboard#index", as: :dashboard
  get "dashboard/:folder", to: "dashboard#index", as: :dashboard_folder
  # folder может быть: "all", "unfiled", "trash" или ID папки (число)
  
  # Projects routes
  resources :projects, only: [:index, :show, :new, :create, :destroy] do
    resources :images, only: [:show]
    collection do
      get :new_project
      post :create_project
      get :upload_modal
    end
  end
  
  # Images actions (удаление, восстановление, модалка, выбор стиля)
  resources :images, only: [] do
    member do
      patch :soft_delete
      patch :restore
      delete :destroy
      get :modal
      get :style_selection
    end
  end
end
