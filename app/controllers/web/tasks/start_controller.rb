# frozen_string_literal: true

class Web::Tasks::StartController < Web::TasksController
  # rest style state modification
  def create
    task.start!
  end

  private

  def task
    # for nested resource id param changes to task_id param
    @task ||= Task.find_by(id: params.fetch(:task_id, nil))
  end
end
