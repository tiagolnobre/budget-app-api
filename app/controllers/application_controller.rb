class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,
              JWT::DecodeError, with: :unauthorized

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

  def unauthorized
    render json: { errors: e.message }, status: :unauthorized
  end
end
