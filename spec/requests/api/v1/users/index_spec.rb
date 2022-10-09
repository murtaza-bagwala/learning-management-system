# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET api/v1/users' do
    context 'with valid parameters' do
      it 'it returns a list of users' do
        create_list(:user, 3)
        get api_v1_users_path

        expect(response.status).to eq 200
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             dob email mobile_no name organization university
                                                                           ])
      end
    end

    context 'with pagination' do
      it 'it returns a paginated list' do
        create_list(:user, 23)
        get "#{api_v1_users_path}?page[number]=5&page[size]=5"
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             dob email mobile_no name organization university
                                                                           ])
      end
    end
  end
end
