class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :confirm_kill

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :avatar_url

    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :avatar_url
  end

  def confirm_kill
    if current_user.present?
      me = User.find(current_user.id)

      if me.enrollments.where({dead: true, confirmed: false}).first != nil
        flash[:alert] = "An assassin has killed you! <a href=\"/kills/confirm\">Click here to confirm your unfortunate demise.</a>".html_safe
      end
    end
  end

end
