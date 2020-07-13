# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login # rubocop:disable Metrics/AbcSize
    @user = User.find_by(email: params[:email].downcase)
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.zone.now + 24.hours
      render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
