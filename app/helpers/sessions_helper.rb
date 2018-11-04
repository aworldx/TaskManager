# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    flash[:notice] = 'You logged in successfully'
    redirect_to user_cab_path
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def user_cab_path
    current_user.admin? ? admin_tasks_path : tasks_path
  end
end
