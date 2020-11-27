Rails.application.routes.draw do
  devise_for :users
  resources :patients
  root 'home#index'
end
