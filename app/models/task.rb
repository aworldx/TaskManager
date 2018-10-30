# frozen_string_literal: true

class Task < ApplicationRecord
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
end
