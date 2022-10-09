# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mobile_no) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:mobile_no).case_insensitive }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    subject { build(:user) }

    it { is_expected.to have_many(:authored_courses) }
    it { is_expected.to have_many(:learnt_courses) }
    it { is_expected.to have_many(:user_courses) }
  end

  describe 'public methods' do
    describe 'author?' do
      context 'when user has authored a course' do
        let(:user) { create(:user) }
        let(:course) { create(:course, author: user) }

        it 'returns true' do
          expect(course.author.author?).to eq true
        end
      end

      context 'when user has not authored any courses' do
        let(:user) { create(:user) }

        it 'returns false' do
          expect(user.author?).to eq false
        end
      end
    end
  end
end
