# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'PUT api/v1/users/:id' do
    context 'with valid parameters' do
      it 'it updates a detail of user' do
        user = create(:user)
        put api_v1_user_path(user), params: {
          data: {
            type: 'users',
            id: user.id,
            attributes: {
              name: 'James Bond',
              university: 'Elearnio'
            }
          }
        }, as: :json, headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: user.id }

        expect(response.status).to eq 200
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          dob email mobile_no name organization university
                                                                        ])
        expect(json_response['data']['attributes']['name']).to eq('James Bond')
        expect(json_response['data']['attributes']['university']).to eq('Elearnio')
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        user = create(:user)
        put api_v1_user_path(user), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end

    context 'if user to update the other user' do
      it 'it returns an unauthorized error' do
        users = create_list(:user, 2)
        put api_v1_user_path(users[0]), params: {
          data: {
            type: 'users',
            id: users[0].id,
            attributes: {
              name: 'James Bond',
              university: 'Elearnio'
            }
          }
        }, as: :json, headers: {
          'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE,
          user: users[1].id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
