Rails.application.routes.draw do
  # http://guides.rubyonrails.org/routing.html
  resources :sessions, only: %i[new create]
  resources :certificates, only: %i[index]
  root to: 'sessions#new'
end
