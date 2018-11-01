# frozen_string_literal: true

# Controller for main page
class Web::WelcomeController < Web::ApplicationController
  def index
    @tasks = Task.includes(:user).all
  end
end
