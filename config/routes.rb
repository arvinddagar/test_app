Rails.application.routes.draw do
  root 'welcome#index'
  resources :settings, only: [:create]
end
