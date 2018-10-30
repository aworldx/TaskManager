# frozen_string_literal: true

require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Task, type: :model do
  context 'task validations' do
    let(:task) { build(:task) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5).is_at_most(50) }
    it { should validate_presence_of(:state) }
    it { should belong_to(:user) }
  end

  context 'state machine tests' do
    let(:task) { build(:task) }

    it 'should have new state after build' do
      expect(task).to have_state(:new)
    end

    it 'should have state started after start event' do
      expect(task).to transition_from(:new).to(:started).on_event(:start)
    end

    it 'should have state finished after finish event' do
      expect(task).to transition_from(:started).to(:finished).on_event(:finish)
    end
  end
end
