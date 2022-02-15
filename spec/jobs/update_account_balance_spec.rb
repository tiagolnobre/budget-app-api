# frozen_string_literal: true

require 'rails_helper'

describe UpdateAccountBalance, type: :job do
  let(:transaction) { create(:transaction) }
  let(:user) { transaction.user }

  describe '#perform' do
    it 'correct account balances update' do
      described_class.perform_now(user: user)
      account = user.accounts.first

      expect(account.positive_balance).to eq(100.0)
      expect(account.negative_balance).to eq(0.0)
    end
  end
end
