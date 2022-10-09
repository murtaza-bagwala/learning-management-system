# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST api/v1/users' do
    context 'with valid parameters' do
      it 'It creates a course' do
        post api_v1_users_path, params: {
          data: {
            type: 'users',
            attributes: {
              name: Faker::Name.name,
              dob: Faker::Date.birthday(min_age: 18, max_age: 65),
              mobile_no: Faker::PhoneNumber.cell_phone_in_e164,
              email: Faker::Internet.email,
              university: Faker::Educator.university,
              organization: Faker::Company.name
            }
          }
        }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE }

        expect(response.status).to eq 201
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          dob email mobile_no name organization university
                                                                        ])
      end
    end
  end

  context 'with invalid parameters' do
    it 'it returns an error' do
      post api_v1_users_path, params: {
        data: {
          type: 'users',
          attributes: {
            name: Faker::Name.name,
            dob: Faker::Date.birthday(min_age: 18, max_age: 65),
            mobile_no: Faker::PhoneNumber.cell_phone,
            email: Faker::Internet.email,
            university: Faker::Educator.university,
            organization: Faker::Company.name
          }
        }
      }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE }

      expect(response.status).to eq 422
      expect(json_response['errors'].first['title']).to eq('is not a number')
      expect(json_response['errors'].first['detail']).to eq('mobile_no - is not a number')
    end
  end
end
