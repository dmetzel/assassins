class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :confirm_kill

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

      if me.enrollments.where({dead: true, confirmed: false}).present?
        flash[:alert] = "An assassin has killed you! <a href=\"/kills/confirm\">Click here to confirm your unfortunate demise.</a>".html_safe
      end
    end
  end

  def current_target(game, user)



    this_enroll = Enrollment.where({user_id: user.id, game_id: game.id}).first

    if this_enroll.user_order == nil || game.status == -1 || game.status == -3

        status = game.status
    else

      if this_enroll.dead == true
        status = 0
      else
        dead = true
        confirmed = true
        i = this_enroll.user_order + 1
        if Enrollment.where({user_order: i, game_id: game.id}).first == nil
          i = 0
        end
        while dead && confirmed
          next_enroll = Enrollment.where({user_order: i, game_id: game.id}).first
          dead = next_enroll.dead
          if dead
            confirmed = next_enroll.confirmed
          end
          i += 1
          if Enrollment.where({user_order: i, game_id: game.id}).first == nil
            i = 0
          end
        end

        if next_enroll.user == current_user
          status = 1
        elsif !confirmed
          status = 2
        else
          status = 3
        end

        target = next_enroll.user

      end
    end

    return status, target

  end

  helper_method :current_target

end
