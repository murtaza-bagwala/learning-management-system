# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons', type: :request do
  describe 'PUT api/v1/courses/:course_id/lessons/:id' do
    context 'with valid parameters' do
      it 'it updates a lesson from a course' do
        lesson = create(:lesson)
        put api_v1_course_lesson_path(lesson.course, lesson), params: {
          title: 'James Bond Part 2',
          notes: 'Once upon a time in ajungle of an amazon',
          video: fixture_file_upload('public/1.1mb-file.mp4', 'video/mp4')
        }, headers: { user: lesson.course.author.id }

        expect(response.status).to eq 200
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title notes video_url
                                                                        ])
        expect(json_response['data']['attributes']['title']).to eq('James Bond Part 2')
        expect(json_response['data']['attributes']['notes']).to eq('Once upon a time in ajungle of an amazon')
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        put api_v1_course_lesson_path(lesson.course, lesson), params: {
          title: 'James Bond Part 2',
          notes: 'Once upon a time in ajungle of an amazon'
        }, headers: { user: Faker::Internet.uuid }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end

    context 'if user tries to update a lesson of unauthored course' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        put api_v1_course_lesson_path(lesson.course, lesson), params: {
          title: 'James Bond Part 2',
          notes: 'Once upon a time in ajungle of an amazon'
        }, headers: { user: create(:user).id }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end

    context 'if user tries to update a lesson which does not belong to a course' do
      it 'it returns an unauthorized error' do
        lesson = create(:lesson)
        put api_v1_course_lesson_path(lesson.course, create(:lesson)), params: {
          title: 'James Bond Part 2',
          notes: 'Once upon a time in ajungle of an amazon'
        }, headers: { user: lesson.course.author.id }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
