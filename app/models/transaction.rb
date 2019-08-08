class Transaction < ApplicationRecord
  TRANSACTION_VALID_HEADERS = %w[date description amount category].freeze

  validates :user_id, presence: true

  scope :for_user, ->(user_id){ where(user_id: user_id) }

  def import_file(file, user)
    transactions = []
    CSV.foreach(file.path, headers: true, header_converters: header_converter) do |row|
      transactions << Transaction.new(row.to_h.merge(user_id: user.id))
    end

    Transaction.import transactions, recursive: true
  end

  def header_converter
    ->(header){ header.downcase }
  end

  def category_tags
    category.split("|").map(&:strip)
  end
end
