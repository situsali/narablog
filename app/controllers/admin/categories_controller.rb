class Admin::CategoriesController < AdminController
  def index
    render :index, locals: { categories: Category.all }
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
