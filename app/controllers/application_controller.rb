# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound,
              JWT::DecodeError, with: :unauthorized

  # rescue_from JWT::ExpiredSignature, with: :expired

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
    @current_user = User.find(@decoded[:user_id])
  end

  private

  def unauthorized(exception)
    render json: { errors: exception.message }, status: :unauthorized
  end
end
