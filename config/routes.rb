<<<<<<< HEAD
Rails.application.routes.draw do
  root 'home#index'
  get 'home/quote'
  get 'home/commercial'
  get 'home/residential'
end
=======
Rails.application.routes.draw do
  resources :employees
  devise_for :users
  root 'home#index'
  get 'home/backOffice'
end
>>>>>>> 117f77d02f446c68f8c77b604a577f64cf8d8491
