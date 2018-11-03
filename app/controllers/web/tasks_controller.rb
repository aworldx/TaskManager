# frozen_string_literal: true

class Web::TasksController < Web::ApplicationController
  before_action :check_task_owner, only: %I[edit destroy]

  def index
    pg = Settings.tasks[:pagination_size]
    @tasks = current_user.tasks.paginate(page: params[:page], per_page: pg)
  end

  def show
    task
  end

  def edit; end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = 'Task created!'
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    if task.update(task_params)
      flash[:notice] = 'Task updated'
      redirect_to task
    else
      render 'edit'
    end
  end

  def destroy
    task.destroy!
    flash[:notice] = 'Task deleted'
    redirect_to user_cab_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :user_id, :image,
                                 :image_cache)
  end

  def task
    @task ||= Task.find_by(id: params.fetch(:id, nil))
  end

  def check_task_owner
    return if task.user == current_user || current_user.admin?

    flash[:danger] = 'You have not permissions to do that!'
    redirect_to user_cab_path
  end
end
