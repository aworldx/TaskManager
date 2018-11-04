# frozen_string_literal: true

class Web::Tasks::ApplicationController < Web::TasksController
  before_action :presenter

  private

  def presenter
    @presenter ||= params[:presenter].constantize.new(current_user)
  end

  def task
    # for nested resource id param changes to task_id param
    @task ||= Task.find_by(id: params.fetch(:task_id, nil))
  end
end
