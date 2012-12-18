AsUser::Engine.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match "/signup", to: 'users#new'
  match "/signin", to: 'sessions#new'
  match "/signout", to: 'sessions#destroy', via: :delete

  get "abouts/index" => "abouts#index"
  root to: "abouts#index"
end
