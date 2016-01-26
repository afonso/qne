Rails.application.routes.draw do
  devise_for :users, controllers: {
                                    omniauth_callbacks: 'users/omniauth_callbacks', 
                                    registrations: 'registrations'
                                  }
  resources :information
  resources :users, only: :show
  root to: "landing#index"
end
