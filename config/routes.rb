Rails.application.routes.draw do


  root to: 'homes#top'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :post_images, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resources :post_comments,only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :followers, :follows, :destroy] do
    resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
  end


  #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'post_images', to: 'post_images#search'
  end


  # 管理者用サイトのrouting
  devise_scope :admins do
    devise_for :admins, controllers: {
        registrations: 'admins/registrations',
        passwords: 'admins/passwords',
        sessions: 'admins/sessions'
    }
  end

  namespace :admin do
    # get 'homes/top' => 'homes#top', as:'top'
    # resources :customers, only: [:index, :edit, :show, :update]
    # resources :products, only: [:index, :create, :new, :edit, :show, :update]
    # resources :orders, only: [:index, :create, :show, :update]
    # resources :order_items, only: [:index, :create, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only:[:index, :edit]
    get 'search' => 'searches#search', as: 'search'
  end



  get 'static_pages/home'
  # test後で消す

end
