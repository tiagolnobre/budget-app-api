# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  describe 'relations' do
    it { is_expected.to have_many(:accounts) }
    it { is_expected.to have_many(:transactions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_length_of(:password) }
  end

  describe 'when email format is invalid' do
    subject { described_class.new(name: 'Patrick Bahringer') }

    it 'is invalid' do
      invalid_emails = %w[user@example,com patrick.bahringer@example.
                          patrick_bahringer@bar_baz.com patrick_bahringer@bar+baz.com]
      invalid_emails.each do |invalid_email|
        subject.email = invalid_email
        expect(subject).not_to be_valid
      end
    end

    it 'is valid' do
      valid_emails = %w[patrick.bahringer@example.com patrick_bahringer-q@example.com patrick.bahringer+b@example.com]
      valid_emails.each do |valid_email|
        subject.email = valid_email
        expect(subject).not_to be_valid
      end
    end
  end

  describe 'creates new_user notification' do
    it 'message is generated correctly' do
      user = create(:user)

      expect(user.notifications.last.to_notification.message)
        .to eq(I18n.t('notifications.new_message_notification.messages.new_record'))
    end
  end
end
