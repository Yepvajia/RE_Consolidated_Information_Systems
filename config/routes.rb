Rails.application.routes.draw do
  resources :employees
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
  get 'home/quote'
  get 'home/commercial'
  get 'home/residential'
end
