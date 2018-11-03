# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let(:tasks) { create_list(:task, 2, user: user) }
  let(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

  context 'GET #index' do
    before(:each) { get :index }

    it 'should populate array of current user tasks' do
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it 'should render index view' do
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    before(:each) { get :show, params: { id: tasks.first.id } }

    it 'should assign requested task to @task' do
      expect(assigns(:task)).to eq tasks.first
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end

  context 'GET #new' do
    before(:each) { get :new }

    it 'should assign a new task to @task' do
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'should render new view' do
      expect(response).to render_template :new
    end
  end

  context 'GET #edit' do
    context 'user edits own task' do
      before(:each) { get :edit, params: { id: tasks.first.id } }

      it 'should assign requested task to @task' do
        expect(assigns(:task)).to eq tasks.first
      end

      it 'should render new view' do
        expect(response).to render_template :edit
      end
    end

    context "edits another's task" do
      context 'by user' do
        it 'should redirect to tasks path and show error message' do
          get :edit, params: { id: anothers_task.id }

          expect(response).to redirect_to tasks_path
          expect(flash[:danger]).to eq 'You have not permissions to do that!'
        end
      end

      context 'by admin' do
        before do
          session[:user_id] = admin.id
          get :edit, params: { id: anothers_task.id }
        end

        it 'should assign requested task to @task' do
          expect(assigns(:task)).to eq anothers_task
        end

        it 'should render new view' do
          expect(response).to render_template :edit
        end
      end
    end
  end

  context 'POST #create' do
    it 'should save new task in database' do
      expect do
        post :create, params: { task: attributes_for(:task, user_id: user) }
      end.to change(Task, :count).by(1)
    end

    it 'should redirect to show view' do
      post :create, params: { task: attributes_for(:task, user_id: user) }
      expect(response).to redirect_to task_path(assigns(:task))
    end
  end

  context 'PATCH #update' do
    let(:task) { tasks.first }
    it 'shuold assign requested task to @task' do
      patch :update, params: { id: task, task: attributes_for(:task) }
      expect(assigns(:task)).to eq task
    end

    it 'shoul change task attributes' do
      patch :update, params: {
        id: task,
        task: {
          name: 'updated name', description: 'new description'
        }
      }

      task.reload
      expect(task.name).to eq 'updated name'
      expect(task.description).to eq 'new description'
    end

    it 'should redirect to updated task' do
      patch :update, params: { id: task, task: attributes_for(:task) }
      expect(response).to redirect_to task
    end
  end

  context 'POST #destroy' do
    context 'user deletes own task' do

    end

    context "deletes another's task" do
      context 'by user' do

      end

      context 'by admin' do

      end
    end
  end
end
