# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  def authenticate_user!
    @current_user = User.find(user_id)
  end

  def current_user
    @current_user
  end

  private

  def user_id
    request.headers['user']
  end
end
