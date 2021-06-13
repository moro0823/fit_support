Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords',
  }

  devise_for :customers, controllers: {
    sessions: 'costomers/sessions',
    passwords: 'costomers/passwords',
    registrations: 'costomers/registrations',
  }

  scope module: :public do
    root "homes#top"
    get 'home/about' => "homes#about"
    get 'public/admin_posts' => "homes#admin_posts"
    resources :genres, only: [:show] do
      get 'public/admin_posts_show' => "homes#admin_posts_show"
    end
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    post '/homes/guest_admin_sign_in', to: 'homes#guest_admin_sign_in'
    post '/homes/ather_guest_sign_in', to: 'homes#ather_guest_sign_in'
    post '/homes/ather_guest_admin_sign_in', to: 'homes#ather_guest_admin_sign_in'
    get 'customer/favorite' => "customers#favorite"
    get 'customer/from_favorite/:id' => "customers#from_favorite", as: :from_favorite
    get 'posts/training' => "posts#training"
    get 'posts/eat' => "posts#eat"
    get 'posts/info' => "posts#info"
    get 'posts/mypost' => "posts#mypost"
    post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
    get 'search' => "searches#search"
    get 'search_friend' => "searches#search_friend", as: :search_friend
    get 'search_post' => "searches#search_post", as: :search_post
    get 'search_mypage_post' => "searches#search_mypage_post", as: :search_mypage_post
    get 'chat/:id' => 'chats#show', as: 'chat'
    put "notification/:id" => "notifications#update", as: :notification
    resources :chats, only: [:create]
    resources :rooms do
      delete 'chat/:id' => 'chats#destroy', as: "chat"
    end

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
    resources :genres, only: [:index, :show, :edit, :create, :update, :destroy]
    get 'customer/post' => 'customers#post'
    resources :admin_users, only: [:show, :edit, :update, :index] do
      resource :my_fitness_places, only: [:create, :destroy]
    end
    resources :staffs, only: [:new, :show, :edit, :create, :update, :destroy]
    resources :personals, only: [:create, :destroy]
    resources :karutes, only: [:show, :create, :update, :edit] do
      resources :notes
    end
  end

  scope module: :admin do
    resources :admin_posts do
      resources :admin_post_comments, only: [:create, :destroy]
      resources :from_admin_comments, only: [:create, :destroy]
    end
  end
end
