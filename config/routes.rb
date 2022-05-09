Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :games, only: [:new, :create, :show] do
    member do
      put 'start', to: "games#start"
    end
  end
end
