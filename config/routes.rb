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
    resources :applications
  end

  namespace :api do
    namespace :v1 do
      resources :applications, defaults: {format: :json}
    end
  end

  resources :users
  resources :applications
  resources :camps do
    member do
      get :apply
      get :already_signed
    end
  end
end
