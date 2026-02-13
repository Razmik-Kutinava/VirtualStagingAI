# frozen_string_literal: true

Rails.application.routes.draw do
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
    end
  end
  
  # Images actions (удаление, восстановление, модалка)
  resources :images, only: [] do
    member do
      patch :soft_delete
      patch :restore
      delete :destroy
      get :modal
    end
  end
end
