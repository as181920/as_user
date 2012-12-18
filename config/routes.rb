AsUser::Engine.routes.draw do
  resources :users
  resources :sessions
  get "abouts/index" => "abouts#index"

  root to: "abouts#index"
end
