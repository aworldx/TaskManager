# frozen_string_literal: true

class Web::Tasks::FinishController < Web::Tasks::StartController
  # rest style state modification
  def create
    task.finish!
  end
end
