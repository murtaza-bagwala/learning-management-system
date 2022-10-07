# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mobile_no) }
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    subject { build(:user) }

    it { is_expected.to have_many(:authored_courses) }
    it { is_expected.to have_many(:learnt_courses) }
    it { is_expected.to have_many(:user_courses) }
  end
end
