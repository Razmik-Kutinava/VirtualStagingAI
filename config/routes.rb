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
  get "dashboard/:folder", to: "dashboard#index", as: :dashboard_folder, constraints: { folder: /all|unfiled|trash|living_room|bedroom|dining_room|kitchen|bathroom|office|main_area/ }
  
  # Projects routes (для будущего расширения)
  resources :projects, only: [:show, :new, :create] do
    resources :images, only: [:show]
  end
end
