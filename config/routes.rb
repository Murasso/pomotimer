Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users, controllers: {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks'
    }

  resources :users, only: [:index, :show, :edit] do
    member do
      get 'week', to: 'users#week', as: 'week'
      get 'month', to: 'users#month', as: 'month'
      get 'year', to: 'users#year', as: 'year'
    end
  end

  resources :study_records, only: [:new, :create, :show]
  
  get "homes/about" => "homes#about", as: "about"
end
