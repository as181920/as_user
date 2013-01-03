Rails.application.routes.draw do
  mount AsUser::Engine => "/as_user"

  root to: "welcome#index"
end
