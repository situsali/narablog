class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin_user

  def index
    render plain: 'halo'
  end

  private

  def authenticate_admin_user
    return if user_signed_in? && current_user&.isadmin

    render_404
  end
end
