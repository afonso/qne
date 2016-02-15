Rails.application.routes.draw do
  root to: "landing#index" # initial page
  
  devise_for :users, controllers: {
                                    omniauth_callbacks: 'users/omniauth_callbacks', 
                                    registrations: 'registrations',
                                    sessions: 'sessions'                             
                                  }

  resources :demands do
    collection do
      get 'success'
    end
  end

  resources :users, only: :show do
    collection do
      get 'users/edit', to: "registrations#edit"
    end
  end

  resources :schools do
    collection do
      get 'update_cities'
    end
  end

  resources :information, only: [:new, :edit, :create, :update] do
    collection do
      get 'update_cities'
    end
  end
  
  match 'information/edit' => 'information#edit', via: :get
  match 'schools/:id/update_cities' => 'schools#update_cities', via: :get
  
  get '*path', to: redirect('/')
end
