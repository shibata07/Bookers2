Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :users
  resources :books
end
