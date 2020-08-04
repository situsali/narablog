class Admin::MediaController < AdminController
  rescue_from ActiveRecord::InvalidForeignKey, with: :cannot_delete
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render :index, locals: { media: Medium.order(created_at: :desc) }
  end

  def show
    @medium = current_media
  end

  def new
    @medium = Medium.new
  end

  def create
    @medium = Medium.create medium_params
    return render :new unless @medium.valid?

    redirect_to admin_media_path
  end

  def edit
    @medium = current_medium
  end

  def update
    @medium = current_medium

    if @medium.update medium_params
      redirect_to admin_media_path
    else
      render :edit
    end
  end

  def destroy
    medium = current_medium
    medium.destroy
    redirect_to admin_media_path,
      notice: "Delete #{media.name} is success"
  end

  private

  def current_medium
    @current_media ||= Medium.find params[:id]
  end

  def cannot_delete
    redirect_to admin_media_path, notice: 'errors'
  end

  def record_not_found
    redirect_to admin_media_path, notice: 'File not found'
  end

  def medium_params
    params.require(:medium).permit(:file)
  end
end
