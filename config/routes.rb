Rails.application.routes.draw do
  # Make YouTube automation the homepage
  root "youtube_automation#index"

  # YouTube automation routes
  resources :youtube_automation, only: [:index] do
    collection do
      post :start_automation
    end
  end

  # Sermon automation routes
  resources :sermon_automation, only: [:index] do
    collection do
      post :start_automation
    end
  end

  # Dashboard routes
  get 'dashboard', to: 'dashboard#index'
  get 'monitoring_dashboard', to: 'monitoring_dashboard#index'
  get 'simple_monitoring', to: 'simple_monitoring#index'

  # Text notes routes
  resources :text_notes

  # Health check
  get 'health', to: 'health#index'

  # Auth routes
  get 'auth/youtube/callback', to: 'auth#youtube_callback'
end
