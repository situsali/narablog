class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActionController::UnknownFormat, with: :not_found
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_token

  protect_from_forgery with: :exception, prepend: true

  def not_found
    respond_to do |format|
      format.html { render 'not_found', layout: 'application', status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  protected

  def configure_permitted_parameters
    attributes = [:name, :username]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for :user, request.fullpath
  end
end
