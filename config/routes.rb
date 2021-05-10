Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :post_images, only: [:new, :create, :index, :show, :destroy]

  get 'static_pages/home'
  # test後で消す



end
