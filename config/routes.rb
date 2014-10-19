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

  get '/s/:room_code/', to: 'students#create', as: :student_code
  get '/t/:room_code/', to: 'teachers#create', as: :teacher_code
end
