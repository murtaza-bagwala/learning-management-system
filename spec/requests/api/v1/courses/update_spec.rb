# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'PUT api/v1/courses/:id' do
    context 'with valid parameters' do
      it 'it updates a detail of a course' do
        course = create(:course)
        put api_v1_course_path(course), params: {
          data: {
            type: 'courses',
            id: course.id,
            attributes: {
              title: 'James Bond Part 2',
              description: 'Once upon a time in ajungle of an amazon'
            }
          }
        }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: course.author.id }

        expect(response.status).to eq 200
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title description published_at published created_by
                                                                        ])
        expect(json_response['data']['attributes']['title']).to eq('James Bond Part 2')
        expect(json_response['data']['attributes']['description']).to eq('Once upon a time in ajungle of an amazon')
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        course = create(:course)
        put api_v1_course_path(course), params: {
          data: {
            type: 'courses',
            id: course.id,
            attributes: {
              title: 'James Bond Part 2',
              description: 'Once upon a time in ajungle of an amazon'
            }
          }
        }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: Faker::Internet.uuid }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end

    context 'if user tries to update an unauthored course' do
      it 'it returns an unauthorized error' do
        courses = create_list(:course, 2)
        put api_v1_course_path(courses[0]), params: {
          data: {
            type: 'courses',
            id: courses[0].id,
            attributes: {
              title: 'James Bond Part 2',
              description: 'Once upon a time in ajungle of an amazon'
            }
          }
        }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: courses[1].author.id }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
