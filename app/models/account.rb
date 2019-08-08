# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user, optional: false

  has_many :transactions, through: :user, dependent: :destroy
  has_many :monthly_stats, dependent: :destroy
  has_many :category_monthly_stats, dependent: :destroy
end
