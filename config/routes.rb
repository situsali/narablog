Rails.application.routes.draw do
  devise_for :users, path: 'member'

  scope :admin, as: :admin, path: '/admin' do
    root 'admin#index'
  end

  namespace :admin do
    resources :posts
    resources :categories
    resources :tags
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
