Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/event', to: 'event#show', as: 'event'
end