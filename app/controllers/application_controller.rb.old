class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_announcements

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |user|
      if current_user.admin_or_staff?
        user.permit(:role)
      end
    end
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:email, :current_password, :gender, :dob, :password, :password_confirmation, :business, :first, :middle, :last, phones_attributes: [:id, :kind, :country, :number, :extension, :type, :_destroy], addresses_attributes: [:id, :street, :apt, :postcode, :city, :state, :country])
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

  def get_announcements
    @announcements = Announcement.show(current_announcement_kind)
  end

  def current_announcement_kind
    (current_user && current_user.admin_or_staff? && Announcement.kinds[:staff]) || Announcement.kinds[:patient]
  end

end
