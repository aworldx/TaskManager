# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  before_action :check_user_logged_in
  include SessionsHelper

  private

  def check_user_logged_in
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_path
  end

  def check_admin
    return if current_user.admin?

    flash[:danger] = 'You have not permissions to do that!'
    redirect_to user_cab_path
  end
end
