Rails.application.routes.draw do
  root "purchases#index"

  resources :purchases
  resources :summaries, only: [:index, :create, :update, :destroy]
end
