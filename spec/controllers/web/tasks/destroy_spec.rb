# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let!(:task) { create(:task, user: user) }
  let!(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

  context 'DELETE #destroy' do
    context 'user deletes own task' do
      it 'should delete task' do
        expect { delete :destroy, params: { id: task.id } }
          .to change(Task, :count).by(-1)
      end

      it 'should redirect to index view' do
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to tasks_path
      end
    end

    context "deletes another's task" do
      context 'by user' do
        it 'should not delete task from db' do
          expect { delete :destroy, params: { id: anothers_task.id } }
            .to change(Task, :count).by(0)
        end

        it 'should redirect to tasks path and show error message' do
          delete :destroy, params: { id: anothers_task.id }

          expect(flash[:danger]).to eq 'You have not permissions to do that!'
          expect(response).to redirect_to tasks_path
        end
      end

      context 'by admin' do
        before(:each) { session[:user_id] = admin.id }

        it 'should delete task' do
          expect { delete :destroy, params: { id: task.id } }
            .to change(Task, :count).by(-1)
        end

        it 'should redirect to index view' do
          delete :destroy, params: { id: task.id }
          expect(response).to redirect_to admin_tasks_path
        end
      end
    end
  end
end
