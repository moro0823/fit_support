Rails.application.routes.draw do
  
  scope module: :public do
    root "homes#top"
  end
  
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords',
  }
  
  devise_for :customers,controllers: {
    sessions: 'costomers/sessions',
    passwords: 'costomers/passwords',
    registrations: 'costomers/registrations'  
  }
  
end
