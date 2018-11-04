# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:another_task) { create(:task, user: another_user) }

  let(:tasks) { create_list(:task, 2, user: user) }

  before(:each) { session[:user_id] = user.id }

  context 'GET #index' do
    before(:each) { get :index }

    it 'should populate array of current user tasks' do
      expect(assigns(:presenter).task_list).to match_array(tasks)
    end

    it 'should show only current user tasks' do
      expect(assigns(:presenter).task_list).not_to include(another_task)
    end

    it 'should render index view' do
      expect(response).to render_template :index
    end
  end
end
