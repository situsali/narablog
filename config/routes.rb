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
  get '/:id', to: 'home#post', as: :post

  post '/:id/comment', to: 'home#post_comment', as: :post_comment
  post '/:id/reply_comment/:comment_id', to: 'home#post_comment_reply', as: :post_comment_reply

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
