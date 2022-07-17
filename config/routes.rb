Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'polly/index', to: "polly#convert"
  get 'maps/index'
  resources :quotes
end
Rails.application.routes.draw do
  get 'maps/index'
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
  get 'maps' => 'maps#index'
  post '/create_lead' => 'home#create_lead'
  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'
end
