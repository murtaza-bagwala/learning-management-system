# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'GET api/v1/courses' do
    context 'with valid parameters' do
      it 'it returns a list of courses' do
        titles = %w[Kubernetes AWS GCP]
        create(:course, title: titles[0])
        create(:course, title: titles[1])
        create(:course, title: titles[2])

        get "#{api_v1_courses_path}?sort=title"

        expect(response.status).to eq 200
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             title description published_at published created_by
                                                                           ])

        expect(json_response['data'][0]['attributes']['title']).to eq 'AWS'
        expect(json_response['data'][1]['attributes']['title']).to eq 'GCP'
        expect(json_response['data'][2]['attributes']['title']).to eq 'Kubernetes'
      end
    end

    context 'with pagination' do
      it 'it returns a paginated list of courses' do
        create_list(:course, 23)
        get "#{api_v1_courses_path}?page[number]=5&page[size]=5"
        expect(json_response['data']).to be_a_kind_of(Array)
        expect(json_response['data'].size).to eq 3
        expect(json_response['data'][0]['attributes'].keys).to match_array(%w[
                                                                             title description published_at published created_by
                                                                           ])
      end
    end
  end
end
