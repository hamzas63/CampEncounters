Rails.application.routes.draw do
  resources :search, only: [:index]
  devise_for :users
 # get 'users/sign_out' => 'devise/sessions#destroy'
  root to: "home#index"

  namespace :admin do
    resources :users
    resources :camps do
      member do
        get :toggle_status
      end
    end
    resources :locations
  end

  resources :users
  resources :registrations
  resources :camps do
    member do
      get :registration
    end
  end
end
