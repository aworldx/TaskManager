# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::SessionsController, type: :controller do
  context 'GET #new' do
    it 'renders new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    let(:user) { create(:user) }

    context 'login with valid credintials' do
      it 'should save user in session and redirect to user cabinet' do
        sign_in(user.email, '123456')

        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'login with invalid credintials' do
      it 'should render new view with flash message' do
        sign_in(user.email, 'wrong password')

        expect(session[:user_id]).not_to be_present
        expect(response).to render_template :new
        expect(flash[:danger]).to be_present
      end
    end

    context 'login admin user' do
      it 'should redirect user to admin path' do
        admin = create(:admin)
        sign_in(admin.email, '123456')

        expect(response).to redirect_to(admin_tasks_path)
      end
    end
  end

  context 'DELETE #destroy' do
    it 'should redirect user to login path' do
      get :destroy
      expect(session[:user_id]).not_to be_present
    end
  end
end
