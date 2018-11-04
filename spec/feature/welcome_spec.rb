# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Welcome', type: :feature do
  let!(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }

  scenario %( User visits home page and sees tasks with fields:
    id, created date, name, user ) do
    sign_in(user.email, user.password)
    visit root_path

    tasks.each do |task|
      section = find(:css, "#task_id_#{task.id}")

      expect(section).to have_text task.id
      expect(section).to have_text I18n.l(task.created_at, format: :short)
      expect(section).to have_text task.name
      expect(section).to have_text task.user_name

      expect(section).not_to have_text task.description
    end
  end
end
