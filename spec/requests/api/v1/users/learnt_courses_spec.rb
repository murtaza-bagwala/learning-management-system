# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET api/v1/users/:user_id/learnt_courses' do
    context 'with valid parameters' do
      it 'it returns a list of learnt_courses' do
        user = create(:user)
        create_list(:user_course, 3, talent: user)
        get api_v1_user_learnt_courses_path(user),
            headers: { 'Accept': JSONAPI::MEDIA_TYPE, 'Content-Type': JSONAPI::MEDIA_TYPE, user: user.id }

        expect(response.status).to eq 200
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             title description published_at published created_by
                                                                           ])
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        user = create(:user)
        get api_v1_user_learnt_courses_path(user), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end
  end
end
