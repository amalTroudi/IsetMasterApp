Rails.application.routes.draw do
  get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'
  resources :users, only: %i[index show create  destroy]
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  resources :motif, only: %i[index show create update destroy ]
  resources :demandes, only: %i[index show create update destroy ]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'
end
