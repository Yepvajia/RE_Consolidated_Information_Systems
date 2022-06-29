Rails.application.routes.draw do
  root 'home#index'
  get 'home/quote'
  get 'home/commercial'
  get 'home/residential'
end
