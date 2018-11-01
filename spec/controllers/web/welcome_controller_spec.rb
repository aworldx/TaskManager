# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::WelcomeController, type: :controller do
  context 'GET #index' do
    let(:user) { create(:user) }
    it 'should render index view if user logged in' do
      session[:user_id] = user.id

      get :index
      expect(response).to render_template(:index)
    end

    it 'should redirect to login path unless user logged in' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end
end
