Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'static_pages/home'
  # test

  root to: 'homes#top'

end
