Rails.application.routes.draw do
  devise_for :users,
             path: 'people',
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           password: 'secret',
                           confirmation: 'verification',
                           unlock: 'unblock',
                           registration: 'register',
                           sign_up: 'sign_up' }

  scope :admin, as: :admin, path: '/admin' do
    root 'admin#index'
  end

  namespace :admin do
    resources :posts
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
