class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin_user

  def index
  end

  private

  def authenticate_admin_user
    return if user_signed_in? && current_user&.isadmin

    not_found
  end
end
