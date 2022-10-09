# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST api/v1/courses' do
    context 'with valid parameters' do
      it 'It creates a course' do
        user = create(:user)
        post api_v1_courses_path, params: {
          data: {
            type: 'courses',
            attributes: {
              title: Faker::Company.name,
              description: Faker::Quote.matz
            }
          }
        }, as: :json, headers: {  'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: user.id }

        expect(response.status).to eq 201
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          title description published_at published created_by
                                                                        ])
      end
    end
  end

  context 'with invalid parameters' do
    it 'it returns an error' do
      user = create(:user)
      post api_v1_courses_path, params: {
        data: {
          type: 'courses',
          attributes: {
            description: Faker::Quote.matz
          }
        }
      }, as: :json, headers: {  'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: user.id }

      expect(response.status).to eq 422
      expect(json_response['errors'].first['title']).to eq("can't be blank")
    end
  end

  context 'unauthorized user' do
    it 'it returns an unauthorized error' do
      user = create(:user)
      post api_v1_courses_path, params: {
        data: {
          type: 'courses',
          attributes: {
            description: Faker::Quote.matz
          }
        }
      }, as: :json, headers: {  'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE }

      expect(json_response['errors']).to be_a_kind_of(Array)
      expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
      expect(response.status).to eq 401
    end
  end
end
