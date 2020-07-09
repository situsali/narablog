class Admin::PostsController < AdminController
  rescue_from ActiveRecord::InvalidForeignKey, with: :cannot_delete
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render :index, locals: { posts: Post.all }
  end

  def show
    @post = current_post
  end

  def new
    @post = Post.new
  end

  def create
    post_paramters = post_params
    post_paramters.merge! user_id: current_user.id, published: true
    @post = Post.create post_paramters
    return render :new unless @post.valid?

    redirect_to admin_posts_path
  end

  def edit
    @post = current_post
  end

  def update
    @post = current_post

    if @post.update post_params
      redirect_to admin_posts_path
    else
      render :edit
    end
  end

  def destroy
    post = current_post
    post.destroy
    redirect_to admin_posts_path,
      notice: "Delete #{post.title} is success"
  end

  private

  def current_post
    @current_post ||= Post.find params[:id]
  end

  def cannot_delete
    redirect_to admin_posts_path, notice: 'errors'
  end

  def record_not_found
    redirect_to admin_posts_path, notice: 'Post not found'
  end

  def post_params
    params.require(:post).permit(:title, :slug, { category_ids: [] }, { tag_ids: [] }, :body)
  end
end
