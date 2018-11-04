# frozen_string_literal: true

class Web::Admin::TasksController < Web::TasksController
  before_action :check_admin

  def index
    @presenter = Web::Tasks::AdminTasksPresenter.new(current_user)
  end
end
