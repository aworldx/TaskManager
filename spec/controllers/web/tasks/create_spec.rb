# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before(:each) { session[:user_id] = user.id }

  context 'POST #create' do
    context 'with valid attributes' do
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

    context 'with invalid attributes' do
      before(:each) do
        post :create, params: {
          task: attributes_for(:task, name: '', user_id: user)
        }
      end

      it 'should not change task attributes' do
        task.reload
        expect(task.name).to eq 'task 1'
      end

      it 're-renders new view' do
        expect(response).to render_template :new
      end
    end
  end
end
