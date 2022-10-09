# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons', type: :request do
  describe 'DELETE api/v1/courses/:course_id/lessons/:id' do
    context 'with valid parameters' do
      it 'it deletes a lesson from a course' do
        lesson = create(:lesson)
        delete api_v1_course_lesson_path(lesson.course, lesson), headers: {
          user: lesson.course.author.id
        }
        expect(response.status).to eq 204
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        delete api_v1_course_lesson_path(lesson.course, lesson), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end

    context 'if user tries to delete a lesson of unauthored course' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        delete api_v1_course_lesson_path(lesson.course, lesson), headers: {
          user: create(:user).id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end

    context 'if user tries to delete a lesson which does not belong to a course' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        delete api_v1_course_lesson_path(lesson.course, create(:lesson)), headers: {
          user: create(:user).id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
