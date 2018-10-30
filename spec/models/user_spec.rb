# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validations' do
    let(:user) { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_least(6).is_at_most(120) }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }
    it { should validate_presence_of(:role) }
    it { should have_many(:tasks).dependent(:destroy) }

    it 'email validation should accept valid adresses' do
      valid_adresses = %w[example@gmail.com example.example@gmail.com
                          A_US-ER@foo.bar.org first.last@foo.jp
                          alice+bob@baz.cn]

      valid_adresses.each do |addr|
        user.email = addr
        expect(user).to be_valid
      end
    end

    it 'email validation should reject invalid adresses' do
      valid_adresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar..com]

      valid_adresses.each do |addr|
        user.email = addr
        expect(user).not_to be_valid
      end
    end

    it 'email adresses should be unique' do
      user.save
      user2 = user.dup
      user2.email.upcase!
      expect(user2).not_to be_valid
    end

    it 'email should be saved as lower-case' do
      user.email = 'ExAmPle@Gmail.cOm'
      user.save

      expect(user.email).to eq('example@gmail.com')
    end
  end
end
