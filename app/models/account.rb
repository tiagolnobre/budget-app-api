class Account < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true

  has_many :transactions, dependent: :destroy
end
