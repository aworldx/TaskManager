# frozen_string_literal: true

class Task < ApplicationRecord
  default_scope { order(:id) }

  include AASM

  belongs_to :user

  validates :name, presence: true, length: { in: 5..50 }
  validates :state, presence: true

  aasm column: :state do
    state :new, initial: true
    state :started, :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end

  delegate :user_name, to: :user
  mount_uploader :image, ImageUploader
end
