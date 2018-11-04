# frozen_string_literal: true

require 'faker'

namespace :db_data_generator do
  desc 'generates some users with faker gem'
  task generate_users: :environment do
    require 'faker'

    10.times do
      pass = Faker::Internet.password(8)
      User.create(email: Faker::Internet.unique.email,
                  password: pass, password_confirmation: pass,
                  role: %I[user admin].sample)
    end
  end

  desc 'generates some tasks with faker gem'
  task generate_tasks: :environment do
    require 'faker'
    
    User.find_each do |user|
      5.times do
        user.tasks.create(name: Faker::Lorem.sentence,
                          description: Faker::Lorem.paragraph,
                          state: %I[new started finished].sample)
      end
    end
  end
end
