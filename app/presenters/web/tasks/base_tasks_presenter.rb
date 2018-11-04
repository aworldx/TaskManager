# frozen_string_literal: true

class Web::Tasks::BaseTasksPresenter
  include Rails.application.routes.url_helpers
  attr_reader :extra_fields

  def initialize(user)
    @user = user
    @extra_fields = [:user_name]
  end

  def task_list
    @task_list ||= Task.includes(:user)
  end

  def show_links?
    false
  end

  def show_field(task, field)
    task.send(field)
  end

  def state_refs(task)
    task.aasm.events.map do |event|
      {
        name: event.name,
        url: send("task_#{event.name}_path", task, presenter: self.class.name),
        options: {
          method: :post,
          remote: true
        }
      }
    end
  end
end
