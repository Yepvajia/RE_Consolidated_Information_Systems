Rails.application.routes.draw do
  get 'maps/index'
  resources :quotes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
Rails.application.routes.draw do
  get 'maps/index'
  resources :quotes
  resources :employees
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
  get 'home/quote'
  get 'home/commercial'
  get 'home/residential'
  get 'home/chart'
  post '/create_lead' => 'home#create_lead'
end
