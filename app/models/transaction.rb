# frozen_string_literal: true

class Transaction < ApplicationRecord
  class ImportError < ArgumentError; end

  TRANSACTION_VALID_HEADERS = %w[date description amount category].freeze
  TRANSACTION_CATEGORIES = %w[
    transport
    eating_out
    bills
    shopping
    groceries
    general
    healthcare
    atm
    finances
    income
  ].freeze

  belongs_to :user, optional: false

  validates :amount, presence: true
  validates :description, presence: true
  validates :date, presence: true

  strip_attributes only: [:category], allow_empty: true

  has_many :accounts, class_name: 'Account', through: :user, dependent: :destroy

  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :negative_sum, -> { where('amount < ?', 0).sum(&:amount) }
  scope :positive_sum, -> { where('amount >= ?', 0).sum(&:amount) }
  scope :month, ->(month) { where("date_part('month', date) = ?", month) }
  scope :year, ->(year) { where("date_part('year', date) = ?", year) }

  def import_file(file, user)
    transactions = []
    CSV.foreach(file.path, headers: true, header_converters: header_converter) do |row|
      row['description'] = row['description'].squish
      # row["date"] = Date.parse(row["date"])
      row['category'] ||= match_categories(row['description'])

      transactions << Transaction.new(row.to_h.merge(user_id: user.id))
    end

    Transaction.import transactions, recursive: true
    transactions
  end

  def header_converter
    ->(header) { header.downcase }
  end

  private

  # def parse_date!(date)
  #  Date.strptime(date, "%d/%m/%y")
  # rescue ArgumentError
  #   errors.add("date", "is invalid format, sould be %d/%m/%y.")
  #   raise Transaction::ImportError, "date", "is invalid format, sould be %d/%m/%y."
  # end

  def match_categories(description)
    case description
    when /(cobrança|energia|edp|servicos|prestacao)/i
      'bills'
    when /(pizza|restaurante|ribs)/i
      'eating_out'
    when /(lidl|continente)/i
      'groceries'
    when /(levantamento|atm)/i
      'atm'
    when /farmacia/i
      'healthcare'
    when /credito/i
      'income'
    else
      'general'
    end
  end
end
