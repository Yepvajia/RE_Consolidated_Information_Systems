Rails.application.routes.draw do
  resources :employees
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
end
