# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authorize_request
  # before_action :find_user, except: %i[show]

  # GET /account/status
  def show
    # @transactions = Transaction.for_user(@current_user)
    status = Account.find_by!(user_id: @current_user.id)

    render json: status, status: :ok
  end
end
