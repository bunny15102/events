Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/event', to: 'event#show', as: 'event'
  post '/event/create_event/:id', to: 'event#create_event', as: 'create_event'
end