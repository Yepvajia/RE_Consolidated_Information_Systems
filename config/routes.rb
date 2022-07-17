Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'polly/index', to: "polly#convert"
  resources :quotes
  resources :employees
  resources :polly
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
  get 'home/quote'
  get 'home/commercial'
  get 'home/residential'
  get 'home/chart'
  post '/create_lead' => 'home#create_lead'
end
