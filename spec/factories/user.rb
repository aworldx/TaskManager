# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@gmail.com' }
    password { '123456' }
    password_confirmation { '123456' }
    role { :user }
  end
end
