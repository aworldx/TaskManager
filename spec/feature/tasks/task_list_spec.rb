# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User tasks list', type: :feature do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:tasks) { create_list(:task, 3, user: user) }
  let(:another_user) { create(:another_user) }
  let!(:another_tasks) { create_list(:task, 3, user: another_user) }

  scenario %( After authorization user can see his own tasks list.
    Task list contains: id, name, description, state, create date ) do
    sign_in(user.email, user.password)

    expect(page).to have_text 'User tasks'

    tasks.each do |task|
      section = find(:css, "#task_id_#{task.id}")

      expect(section).to have_text task.id
      expect(section).to have_text task.name
      expect(section).to have_text task.description
      expect(section).to have_text task.state
      expect(section).to have_text I18n.l(task.created_at, format: :short)

      expect(section).not_to have_text task.user_name
    end

    another_tasks.each do |task|
      expect(page).not_to have_css("#task_id_#{task.id}")
    end
  end

  scenario %( After authorization admin user can see all tasks.
    Task list contains: id, name, description, state, create date, user ) do
    sign_in(admin.email, admin.password)

    Task.find_each do |task|
      section = find(:css, "#task_id_#{task.id}")

      expect(section).to have_text task.id
      expect(section).to have_text task.name
      expect(section).to have_text task.description
      expect(section).to have_text task.state
      expect(section).to have_text I18n.l(task.created_at, format: :short)
      expect(section).to have_text task.user_name
    end
  end
end
