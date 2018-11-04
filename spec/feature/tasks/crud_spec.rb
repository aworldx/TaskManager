# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'CRUD tasks', type: :feature do
  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  context 'by user' do
    before(:each) { sign_in(user.email, user.password) }

    scenario 'User creates new task' do
      click_link 'Create new'
      expect(current_path).to eq new_task_path

      fill_in 'Name', with: 'new task'
      fill_in 'Description', with: 'new description'

      image_path = Rails.root.join('spec/support/upload/', 'example.jpeg')
      attach_file 'Image', image_path

      click_button 'Create Task'
      expect(page).to have_text 'Task created!'

      expect(page).to have_css("img[src*='example.jpeg']")

      visit tasks_path
      expect(page).to have_text 'new description'
    end

    scenario 'User updates task' do
      click_link 'edit'
      expect(current_path).to eq edit_task_path(task)

      fill_in 'Name', with: 'updated task'
      click_button 'Update Task'

      expect(page).to have_text 'Task updated'

      visit tasks_path

      section = find(:css, "#task_id_#{task.id}")
      expect(section).to have_text 'updated task'
    end

    scenario 'User deletes task' do
      expect(page).to have_css "#task_id_#{task.id}"

      click_link 'delete'

      expect(page).to have_text 'Task deleted'
      expect(page).not_to have_css "#task_id_#{task.id}"
    end
  end

  context 'by admin' do
    let!(:admin) { create(:admin) }
    before(:each) { sign_in(admin.email, admin.password) }

    scenario 'Admin user can edit another user task' do
      click_link 'edit'

      expect(current_path).to eq edit_task_path(task)

      fill_in 'Name', with: 'updated by admin'
      click_button 'Update Task'

      expect(page).to have_text 'Task updated'

      visit admin_tasks_path

      section = find(:css, "#task_id_#{task.id}")
      expect(section).to have_text 'updated by admin'
    end

    scenario 'Admin user can delete another user task' do
      click_link 'delete'

      expect(page).to have_text 'Task deleted'
      expect(page).not_to have_css "#task_id_#{task.id}"
    end

    scenario 'Admin user can change user in task' do
      another_user = create(:another_user)

      section = find(:css, "#task_id_#{task.id}")
      expect(section).to have_text task.user_name

      click_link 'edit'

      select another_user.user_name, from: 'User'

      click_button 'Update Task'
      expect(page).to have_text 'Task updated'

      visit admin_tasks_path

      section = find(:css, "#task_id_#{task.id}")
      expect(section).to have_text another_user.user_name
    end
  end
end
