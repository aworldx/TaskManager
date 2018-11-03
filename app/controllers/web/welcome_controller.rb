# frozen_string_literal: true

# Controller for main page
class Web::WelcomeController < Web::ApplicationController
  def index
    pg = Settings.tasks[:pagination_size]
    @tasks = Task.paginate(page: params[:page], per_page: pg)
  end
end
