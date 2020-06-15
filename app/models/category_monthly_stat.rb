# frozen_string_literal: true

class CategoryMonthlyStat < ApplicationRecord
  belongs_to :account

  # validates :category
  validates_inclusion_of :month, in: 1..12
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 2000 }

  validates :account, uniqueness: { scope: %i[category month year] }
end
