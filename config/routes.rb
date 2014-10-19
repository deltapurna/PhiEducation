Rails.application.routes.draw do
  root 'rooms#new'

  resources :rooms do
    resource :questions
  end

  resources :questions, only: [] do
    resources :answers
  end

  resources :teachers
  resources :students
end
