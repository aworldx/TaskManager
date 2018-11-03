# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let(:tasks) { create_list(:task, 2, user: user) }
  let(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

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
end
