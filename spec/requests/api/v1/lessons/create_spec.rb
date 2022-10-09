# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons', type: :request do
  describe 'POST api/v1/courses/:course_id/lessons' do
    context 'with valid parameters' do
      it 'It creates a lesson for a course' do
        course = create(:course)
        post api_v1_course_lessons_path(course), params: {
          title: Faker::Company.name,
          notes: Faker::Quote.matz,
          video: fixture_file_upload('public/1mb-file.mp4', 'video/mp4')
        }, headers: { user: course.author.id }

        expect(response.status).to eq 201
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title notes video_url
                                                                        ])
      end
    end

    context 'with invalid parameters' do
      it 'it returns an error' do
        course = create(:course)
        post api_v1_course_lessons_path(course), params: {
          title: Faker::Company.name,
          notes: Faker::Quote.matz,
          video: fixture_file_upload('public/5mb-file.mp4', 'video/mp4')
        }, headers: { user: course.author.id }
        expect(response.status).to eq 422

        expect(json_response['errors'].first).to eq('Validation failed: Video File size should be less than 4 MB')
      end
    end

    context 'if unauthored user tries to create a lesson for a course' do
      it 'it returns an unauthorized error' do
        course = create(:course)
        post api_v1_course_lessons_path(course), params: {
          title: Faker::Company.name,
          notes: Faker::Quote.matz,
          video: fixture_file_upload('public/5mb-file.mp4', 'video/mp4')
        }, headers: { user: create(:user).id }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
