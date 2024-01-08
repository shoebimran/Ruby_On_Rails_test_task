# frozen_string_literal: true

Rails.application.routes.draw do
  get 'daily_records/report'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users

  get 'report', to: 'daily_records#report'
  # Defines the root path route ("/")
  root 'users#index'
end
