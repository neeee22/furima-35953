Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders, only: %i[index create]
  end
  resources :users,only:[:show]
  resources :cards,only:[:new,:create,:destroy]
end
