# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  has_many :transactions, dependent: :destroy
  has_many :monthly_stats, dependent: :destroy
  has_many :category_monthly_stats, dependent: :destroy
end
