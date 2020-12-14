Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :user, only: %i[index show]
end
