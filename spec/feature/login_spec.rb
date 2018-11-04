# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let(:user) { create(:user) }
  scenario 'User logs in' do
    sign_in(user.email, user.password)

    expect(page).to have_text 'You logged in successfully'
  end
end
