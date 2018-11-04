# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:user) { create(:user) }
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
