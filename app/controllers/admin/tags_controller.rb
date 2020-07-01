class Admin::TagsController < AdminController
  rescue_from ActiveRecord::InvalidForeignKey, with: :cannot_delete
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render :index, locals: { tags: Tag.all }
  end

  def show
    @tag = current_tag
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create tag_params
    return render :new unless @tag.valid?

    redirect_to admin_tags_path
  end

  def edit
    @tag = current_tag
  end

  def update
    @tag = current_tag

    if @tag.update tag_params
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    tag = current_tag
    tag.destroy
    redirect_to admin_tags_path,
      notice: "Delete #{tag.name} is success"
  end

  private

  def current_tag
    @current_tag ||= Tag.find params[:id]
  end

  def cannot_delete
    redirect_to admin_tags_path, notice: 'errors'
  end

  def record_not_found
    redirect_to admin_tags_path, notice: 'Tag not found'
  end

  def tag_params
    params.require(:tag).permit(:name, :slug, :description)
  end
end
