# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET api/v1/users/:id' do
    context 'with valid parameters' do
      it 'it returns a detail of user' do
        user = create(:user)
        get api_v1_user_path(user), headers: {
          user: user.id
        }

        expect(response.status).to eq 200
        expect(json_response['data']['attributes'].keys).to match_array(%w[
                                                                          dob email mobile_no name organization university
                                                                        ])
        expect(json_response['data']['id']).to eq user.id
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        user = create(:user)
        get api_v1_user_path(user), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end
  end
end
