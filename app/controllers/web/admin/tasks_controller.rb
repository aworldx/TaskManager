# frozen_string_literal: true

class Web::Admin::TasksController < Web::TasksController
  before_action :check_admin

  def index
    pg = Settings.tasks[:pagination_size]
    @tasks = Task.includes(:user).paginate(page: params[:page], per_page: pg)
  end
end
