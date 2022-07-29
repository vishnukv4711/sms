Rails.application.routes.draw do
  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'home#index'
  resources :users
  resources :students
  resources :academics
  get 'schools', to: "schools#index"

end
