Rails.application.routes.draw do
  devise_for :users
  get '/admin', to: 'admin#index', as: :root_admin

  namespace :admin do
    resources :posts
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
