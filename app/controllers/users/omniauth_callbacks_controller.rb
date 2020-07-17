class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    gmail = request.env['omniauth.auth']
  end
end
