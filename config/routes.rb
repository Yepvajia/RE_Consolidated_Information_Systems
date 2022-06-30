Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :employees
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
end
