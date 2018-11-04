# frozen_string_literal: true

class Web::Tasks::StartController < Web::Tasks::ApplicationController
  def create
    task.start!
  end
end
