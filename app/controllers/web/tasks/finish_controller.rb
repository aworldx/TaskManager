# frozen_string_literal: true

class Web::Tasks::FinishController < Web::Tasks::ApplicationController
  def create
    task.finish!
  end
end
