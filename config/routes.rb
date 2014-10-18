Rails.application.routes.draw do
  root 'rooms#new'

  resources :rooms
end
