# frozen_string_literal: true

class Web::Tasks::UserTasksPresenter < Web::Tasks::BaseTasksPresenter
  def initialize(user)
    super(user)

    @extra_fields = [:description]
    @show_links = true
  end

  def show_links?
    true
  end

  def task_list
    @task_list ||= @user.tasks
  end
end
