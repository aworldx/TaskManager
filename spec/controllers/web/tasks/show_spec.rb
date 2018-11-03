# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:admin) { create(:admin) }

  let(:tasks) { create_list(:task, 2, user: user) }
  let(:anothers_task) { create(:task, user: another_user) }

  before(:each) { session[:user_id] = user.id }

  context 'GET #show' do
    before(:each) { get :show, params: { id: tasks.first.id } }

    it 'should assign requested task to @task' do
      expect(assigns(:task)).to eq tasks.first
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end
end
