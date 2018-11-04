# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Task state editing', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:task) { create(:task, user: user) }

  scenario 'User can switch task state' do
    sign_in(user.email, user.password)
    section = find(:css, "#task_id_#{task.id}")

    expect(section).to have_link 'start'
    click_link 'start'

    expect(section).to have_link 'finish'
    click_link 'finish'

    expect(section).not_to have_link 'finish'
  end
end
