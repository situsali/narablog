class Admin::CategoriesController < AdminController
  rescue_from ActiveRecord::InvalidForeignKey, with: :cannot_delete
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render :index, locals: { categories: Category.all }
  end

  def show
    @category = current_category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create category_params
    return render :new unless @category.valid?

    redirect_to admin_categories_path
  end

  def edit
    @category = current_category
  end

  def update
    @category = current_category

    if @category.update category_params
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    category = current_category
    category.destroy
    redirect_to admin_categories_path,
      notice: "Delete #{category.name} is success"
  end

  private

  def current_category
    @current_category ||= Category.find params[:id]
  end

  def cannot_delete
    redirect_to admin_categories_path, notice: 'errors'
  end

  def record_not_found
    redirect_to admin_categories_path, notice: 'Category not found'
  end

  def category_params
    params.require(:category).permit(:name, :slug, :description)
  end
end
