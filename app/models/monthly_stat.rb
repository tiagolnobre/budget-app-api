# frozen_string_literal: true

class MonthlyStat < ApplicationRecord
  belongs_to :account, optional: false

  validates :month, inclusion: { in: 1..12 }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 2000 }
  # validates_length_of :year, is: 4,  message: "Must be 4 digits"

  validates :account, uniqueness: { scope: %i[month year] }
end
