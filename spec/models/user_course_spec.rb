# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  describe 'associations' do
    subject { build(:user_course) }

    it { should belong_to(:talent).class_name('User') }
    it { should belong_to(:course) }
  end
end
