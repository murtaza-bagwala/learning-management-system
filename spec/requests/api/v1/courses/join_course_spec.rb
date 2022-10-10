# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST api/v1/courses/:course_id/join_course' do
    context 'with valid parameters' do
      it 'User joins a course successfully' do
        user = create(:user)
        course = create(:course)
        post api_v1_course_join_course_path(course),
             headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: user.id }

        expect(response.status).to eq 201
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title description published_at published created_by
                                                                        ])
      end
    end
  end

  context 'with invalid parameters' do
    it 'it returns an error' do
      course = create(:course)
      post api_v1_course_join_course_path(course),
           headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: Faker::Internet.uuid }

      expect(json_response['errors']).to be_a_kind_of(Array)
      expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
      expect(response.status).to eq 401
    end
  end

  context 'when owner tries to join his own course' do
    it 'it returns a forbidden error' do
      course = create(:course)
      post api_v1_course_join_course_path(course),
           headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: course.author.id }

      expect(json_response['errors']).to be_a_kind_of(Array)
      expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
      expect(response.status).to eq 403
    end
  end
end
