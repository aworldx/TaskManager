# frozen_string_literal: true

# Controller for main page
class Web::WelcomeController < Web::ApplicationController
  def index
    @presenter = Web::Tasks::BaseTasksPresenter.new(current_user)
  end
end
