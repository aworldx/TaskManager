# frozen_string_literal: true

class Web::Tasks::AdminTasksPresenter < Web::Tasks::BaseTasksPresenter
  def initialize(user)
    super(user)

    @extra_fields = %I[description user_name]
    @show_links = true
  end

  def show_links?
    true
  end

  def task_list
    @task_list ||= Task.includes(:user)
  end
end
