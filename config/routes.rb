Rails.application.routes.draw do

  get 'searches/search'
  get 'search/search'
    devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords',
  }

  devise_for :customers,controllers: {
    sessions: 'costomers/sessions',
    passwords: 'costomers/passwords',
    registrations: 'costomers/registrations'
  }

  scope module: :public do
    root "homes#top"
    get 'home/about' => "homes#about"
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    get 'customer/favorite' => "customers#favorite"
    get 'customer/from_favorite/:id' => "customers#from_favorite", as: :from_favorite
    get 'posts/training' => "posts#training"
    get 'posts/eat' => "posts#eat"
    get 'posts/info' => "posts#info"
    post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
    get 'search' => "searches#search"
    get 'search_friend' => "searches#search_friend", as: :search_friend

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      delete "customer/favorite" => "favorites#destroy_favorite"
    end
    resources :customers, only: [:edit, :update, :show] do
      get  'follower' => 'customers#follower', as: 'follower'
      get  'followed' => 'customers#followed', as: 'followed'
    end
  end

  namespace :admin do
    resources :customers, only: [:index, :show]
  end


end
