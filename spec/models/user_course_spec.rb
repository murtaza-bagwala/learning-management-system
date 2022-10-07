# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  describe 'associations' do
    subject { build(:user_course) }

    it { is_expected.to have_many(:authored_courses) }
    it { is_expected.to have_many(:learnt_courses) }
    it { is_expected.to have_many(:user_courses) }
  end
end
