Rails.application.routes.draw do
  devise_for :users
  resources :patients
  root 'home#index'
  get 'my_patients', to: 'patients#my_patients'
  get 'search_patient', to: 'patients#search'
end
