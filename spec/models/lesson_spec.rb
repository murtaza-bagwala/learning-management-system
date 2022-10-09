# frozen_string_literal: true

require 'rails_helper'

# frozen_string_literal: true

RSpec.describe Lesson, type: :model do
  describe 'validations' do
    subject { build(:lesson) }

    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    subject { build(:lesson) }

    it { should belong_to(:course) }
  end
end
