# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'DELETE api/v1/courses/:id' do
    context 'with valid parameters' do
      it 'it deletes a course' do
        course = create(:course)
        delete api_v1_course_path(course), headers: {
          user: course.author.id
        }
        expect(response.status).to eq 204
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

    context 'if user tries to delete an unauthored course' do
      it 'it returns an unauthorized error' do
        course = create(:course)
        delete api_v1_course_path(course), headers: {
          user: create(:user).id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
