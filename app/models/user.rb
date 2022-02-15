# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :accounts, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 6}, if: -> { new_record? || !password.nil? }

  after_create_commit :notify_recipient

  private

  def notify_recipient
    NewMessageNotification.with(type: self.class.name, message_key: :new_record).deliver_later(self)
  end
end
