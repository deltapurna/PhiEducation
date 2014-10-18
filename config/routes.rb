Rails.application.routes.draw do
  root 'rooms#new'

  resources :rooms do
    resource :questions
  end

  resources :teachers
end
