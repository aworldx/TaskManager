# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  skip_before_action :check_user_logged_in, only: %I[new create]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in user
      return
    end

    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
