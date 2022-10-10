# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  include Authenticable

  before_action :authenticate_user!

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :handle_not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error
  rescue_from ForbiddenPathError, with: :forbidden
  rescue_from NotAuthorizedError, with: :unauthorized

  def context
    { current_user: current_user }
  end

  private

  def handle_not_found_error(exception)
    message = exception.message || I18n.t('errors.not_found')

    render json: { errors: [message] }, status: :not_found
  end

  def handle_validation_error(exception)
    render json: { errors: [exception.message] }, status: 422
  end

  def unauthorized
    render json: { errors: ['unauthorized to access the record'] }, status: 401
  end

  def forbidden(_exception)
    render json: { errors: ['forbidden to perform this action'] }, status: 403
  end
end
