class Admin::PagesController < AdminController
  rescue_from ActiveRecord::InvalidForeignKey, with: :cannot_delete
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render :index, locals: { pages: Page.all }
  end

  def show
    @page = current_page
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.create page_params
    return render :new unless @page.valid?

    redirect_to admin_pages_path
  end

  def edit
    @page = current_page
  end

  def update
    @page = current_page

    if @page.update page_params
      redirect_to admin_pages_path
    else
      render :edit
    end
  end

  def destroy
    page = current_page
    page.destroy
    redirect_to admin_pages_path,
      notice: "Delete #{page.title} is success"
  end

  private

  def current_page
    @current_page ||= Page.find params[:id]
  end

  def cannot_delete
    redirect_to admin_pages_path, notice: 'errors'
  end

  def record_not_found
    redirect_to admin_pages_path, notice: 'Page not found'
  end

  def page_params
    params.require(:page).permit(:title, :slug, :body)
  end
end
