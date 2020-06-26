class Admin::PostsController < AdminController
  def index
    render :index, locals: { posts: Post.all }
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
