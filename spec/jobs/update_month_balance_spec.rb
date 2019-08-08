# frozen_string_literal: true

require 'rails_helper'

describe UpdateMonthBalance, type: :job do
  let(:transaction) { create(:transaction) }
  let(:account) { create(:account, user: transaction.user) }
  let(:date) { transaction.date }

  describe '#perform' do
    it 'correct updates monthly balances' do
      expect do
        described_class.perform_now(account: account, month: date.month, year: date.year)
      end.to change(MonthlyStat, :count).by(1)

      category_monthly_stat = MonthlyStat.last

      expect(category_monthly_stat.year).to eq(date.year)
      expect(category_monthly_stat.month).to eq(date.month)
      expect(category_monthly_stat.positive_balance).to eq(100.0)
      expect(category_monthly_stat.negative_balance).to eq(0.0)
    end
  end
end
