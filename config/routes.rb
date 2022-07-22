Rails.application.routes.draw do
  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#index'
  resources :users
  resources :students
  resources :academics

end
