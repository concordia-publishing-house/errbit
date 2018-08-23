class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_time_zone

  # Devise override - After login, if there is only one app,
  # redirect to that app's path instead of the root path (apps#index).
  def stored_location_for(resource)
    location = super || root_path
    (location == root_path && current_user.apps.count == 1) ? app_path(current_user.apps.first) : location
  end

  rescue_from ActionController::RedirectBackError, with: :redirect_to_root

protected


  ##
  # Check if the current_user is admin or not and redirect to root url if not
  #
  def require_admin!
    unless user_signed_in? && current_user.admin?
      flash[:error] = "Sorry, you don't have permission to do that"
      redirect_to_root
    end
  end

  def redirect_to_root
    redirect_to(root_path)
  end

  def set_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end

  def authenticate_user_from_token!
    user_token = params[User.token_authentication_key].presence
    user       = user_token && User.find_by_authentication_token(user_token)

    if user
      sign_in user, store: false
    end
  end

end
