class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |user|
      if current_user.admin_or_staff?
        user.permit(:role)
      end
    end
  end

  def require_admin!
    unless current_user && current_user.admin_or_staff?
      respond_to do |format|
        format.html { redirect_to root_url, alert: 'Access denied'}
        format.json { head :unauthorized }
      end
    end
  end

end
