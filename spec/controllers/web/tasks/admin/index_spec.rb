# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::Admin::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  context 'GET #index' do
    context 'by user with role user' do
      it 'should redirect to user tasks' do
        session[:user_id] = user.id
        get :index

        expect(response).to redirect_to tasks_path
        expect(flash[:danger]).to eq 'You have not permissions to do that!'
      end
    end

    context 'by user with role admin' do
      before(:each) { session[:user_id] = admin.id }
      before(:each) { get :index }

      it 'should populate array of all tasks' do
        expect(assigns(:presenter).task_list).to match_array(Task.all)
      end

      it 'should render index view' do
        expect(response).to render_template :index
      end
    end
  end
end
