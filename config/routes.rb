Rails.application.routes.draw do
  # http://guides.rubyonrails.org/routing.html
  resource :sessions, only: %i[new create destroy]
  resources :certificates, only: %i[index]
  root to: 'sessions#new'
end
