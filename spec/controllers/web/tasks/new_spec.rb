# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let(:tasks) { create_list(:task, 2, user: user) }
  let(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

  context 'GET #new' do
    before(:each) { get :new }

    it 'should assign a new task to @task' do
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'should render new view' do
      expect(response).to render_template :new
    end
  end
end
