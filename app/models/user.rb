# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email&.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { in: 6..120 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { in: 6..30 }
  validates :role, presence: true

  has_secure_password
  enum role: %I[admin user]
end
