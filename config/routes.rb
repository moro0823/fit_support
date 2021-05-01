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
    resources :customers, only: [:edit, :update, :show]
  end

  namespace :admin do
    resources :customers, only: [:index, :show]
  end


end
