# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons', type: :request do
  describe 'GET api/v1/courses/:course_id/lessons' do
    context 'with valid parameters' do
      it 'it returns a list of lessons for a course' do
        course = create(:course)
        create_list(:lesson, 3, course: course)
        get api_v1_course_lessons_path(course), headers: {
          user: course.author.id
        }

        expect(response.status).to eq 200
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             title notes video_url
                                                                           ])
      end
    end

    context 'with pagination' do
      it 'it returns a paginated list of lessons for a course' do
        course = create(:course)
        create_list(:lesson, 23, course: course)

        get "#{api_v1_course_lessons_path(course)}?page[number]=5&page[size]=5", headers: {
          user: course.author.id
        }

        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             title notes video_url
                                                                           ])
      end
    end
  end
end
