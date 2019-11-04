class Transaction < ApplicationRecord
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

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true
  validates :description, presence: true
  validates :date, presence: true

  has_one :account

  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :negative_sum, -> { where("amount < ?", 0).sum(&:amount) }
  scope :positive_sum, -> { where("amount >= ?", 0).sum(&:amount) }
  scope :month, ->(month) { where("date_part('month', date) = ?", month) }
  scope :year, ->(year) { where("date_part('year', date) = ?", year) }

  def import_file(file, user)
    transactions = []
    CSV.foreach(file.path, headers: true, header_converters: header_converter) do |row|
      row["description"] = row["description"].squish
      row["category"] ||= match_categories(row["description"])
      transactions << Transaction.new(row.to_h.merge(user_id: user.id))
    end

    Transaction.import transactions, recursive: true
    transactions
  end

  def header_converter
    ->(header){ header.downcase }
  end

  def match_categories(description)
    case description
    when /(cobrança|energia|edp|servicos|prestacao)/i
      "bills"
    when /(pizza|restaurante|ribs)/i
      "eating_out"
    when /(lidl|continente)/i
      "groceries"
    when /(levantamento|atm)/i
      "atm"
    when /farmacia/i
      "healthcare"
    when /credito/i
      "income"
    else
      "general"
    end
  end
end
