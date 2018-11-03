# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let(:task) { create(:task, user: user) }
  let(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

  context 'PATCH #update' do
    context 'with valid attributes' do
      it 'should assign requested task to @task' do
        patch :update, params: { id: task, task: attributes_for(:task) }
        expect(assigns(:task)).to eq task
      end

      it 'should change task attributes' do
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

    context 'with invalid attributes' do
      before(:each) do
        patch :update, params: {
          id: task, task: attributes_for(:task, name: '')
        }
      end

      it 'should not change task attributes' do
        task.reload
        expect(task.name).to eq 'task 1'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end
end
