Rails.application.routes.draw do
  resources :search, only: [:index]
  devise_for :users
 # get 'users/sign_out' => 'devise/sessions#destroy'
  root to: "home#index"

  namespace :admin do
    resources :users, :camps, :locations
  end
  resources :users
  resources :camps
end
