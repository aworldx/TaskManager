# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before(:each) { session[:user_id] = user.id }

  context 'GET #show' do
    before(:each) { get :show, params: { id: task.id } }

    it 'should assign requested task to @task' do
      expect(assigns(:task)).to eq task
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end
end
