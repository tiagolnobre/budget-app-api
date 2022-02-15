# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authorize_request
  before_action :require_file, only: [:import_file]
  before_action :missing_headers?, only: [:import_file], unless: -> { params[:file].blank? }

  # GET /transactions
  def show
    @transactions = Transaction.for_user(@current_user)
    render json: @transactions
  rescue ActiveRecord::RecordNotFound
    render json: {errors: "User not found"}, status: :not_found
  end

  # POST transactions/import
  def import_file
    transactions = transaction.import_file(params[:file], @current_user)

    UpdateAccountBalance.perform_now(user: @current_user)
    UpdateMonthlyBalances.perform_later(
      user: @current_user,
      formatted_dates: transactions.map(&:date).map { |c| {month: c.month, year: c.year} }.uniq
    )

    render :show, status: :created
  rescue
    render json: {errors: transaction.errors.full_messages}, status: :unprocessable_entity
  end

  private

  def missing_headers?
    csv_headers = CSV.open(params[:file].tempfile,
      headers: true,
      header_converters: transaction.header_converter).read.headers
    return if match_headers?(csv_headers)

    render json: {errors: "Invalid headers. Missing: #{Transaction::TRANSACTION_VALID_HEADERS - csv_headers}"},
      status: :unprocessable_entity
  end

  def match_headers?(csv_headers)
    (csv_headers - Transaction::TRANSACTION_VALID_HEADERS).empty?
  end

  def require_file
    render json: {errors: "Missing file"}, status: :not_found unless params[:file]
  end

  def transaction
    @transaction ||= Transaction.new
  end
end
