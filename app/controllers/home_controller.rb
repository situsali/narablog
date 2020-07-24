class HomeController < ApplicationController
  def index
    posts = Post.where(published: true)
    render :index, locals: { posts: posts }
  end

  def post
    @post = current_post
  end

  def post_comment
    comment_params = params.require(:comment).permit(:body)
    comment_params.merge! user_id: current_user.id

    @post = current_post
    @post.comments.create comment_params

    redirect_to post_path
  end

  private

  def current_post
    @current_post ||= Post.find_by! slug: params[:id], published: true
  end
end
