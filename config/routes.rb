Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :chats, only: [:new, :create, :show, :index]

  root 'chats#index'

  mount ActionCable.server => '/cable'
end
