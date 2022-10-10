# frozen_string_literal: true

require 'rails_helper'

# frozen_string_literal: true

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'DELETE api/v1/users/:id' do
    context 'with valid parameters' do
      it 'it delates an user' do
        user = create(:user)
        delete api_v1_user_path(user), headers: {
          user: user.id
        }
        expect(response.status).to eq 204
      end
    end

    context 'with valid parameters' do
      it 'it delates an author and transfers his/her courses to another author' do
        course1 = create(:course)
        course2 = create(:course)
        user1 = course1.author
        user2 = course2.author

        delete api_v1_user_path(user1), headers: {
          user: user1.id
        }
        expect(response.status).to eq 204
        expect(user2.authored_courses.size).to eq 2
        expect(user2.authored_courses.find(course1.id)).not_to be nil
      end
    end

    context 'with valid parameters and no new author found' do
      it 'it return a forbidden error' do
        course = create(:course)

        delete api_v1_user_path(course.author), headers: {
          user: course.author.id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end

    context 'unauthorized user' do
      it 'it returns an unauthorized error' do
        user = create(:user)
        delete api_v1_user_path(user), headers: {
          user: Faker::Internet.uuid
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'unauthorized to access the record'
        expect(response.status).to eq 401
      end
    end

    context 'if user tries to delete the other users' do
      it 'it returns an unauthorized error' do
        users = create_list(:user, 2)
        delete api_v1_user_path(users[0]), headers: {
          user: users[1].id
        }

        expect(json_response['errors']).to be_a_kind_of(Array)
        expect(json_response['errors'][0]).to eq 'forbidden to perform this action'
        expect(response.status).to eq 403
      end
    end
  end
end
