# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'get api/v1/courses/:id' do
    context 'with valid parameters' do
      it 'it returns a details of a course' do
        course = create(:course)
        get api_v1_course_path(course), headers: {
          user: course.author.id
        }
        expect(response.status).to eq 200
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title description published_at published created_by
                                                                        ])
        expect(json_response['data']['id']).to eq course.id
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        course = create(:course)
        delete api_v1_course_path(course), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end
  end
end
