Rails.application.routes.draw do
  devise_for :users
  root to: "games#new"

  resources :games, only: [:new, :create, :show] do
    member do
      put 'start', to: "games#start"
    end
  end
end
