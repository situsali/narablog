class HomeController < ApplicationController
  def index
    posts = Post.where(published: true)
    render :index, locals: { posts: posts }
  end

  def post
    post = Post.find_by slug: params[:id]
    render :post, locals: { post: post }
  end
end
