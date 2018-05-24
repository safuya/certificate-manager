# frozen_string_literal: true

Rails.application.routes.draw do
  # http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  resource :sessions, only: %i[new create destroy]
  resources :certificates, only: %i[index new create edit update destroy]
  resources :load_balancers, only: %i[index edit update]
  root to: 'sessions#new'
end
