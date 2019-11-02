class ApplicationController < ActionController::API
  include ActionController::Serialization

  before_action :set_raven_context

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

  def unauthorized(ex)
    render json: { errors: ex.message }, status: :unauthorized
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
