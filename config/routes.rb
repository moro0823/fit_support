Rails.application.routes.draw do

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
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      delete "customer/favorite" => "favorites#destroy_favorite"
    end
    resources :customers, only: [:edit, :update, :show]
  end

  namespace :admin do
    resources :customers, only: [:index, :show]
  end


end
