# frozen_string_literal: true

require "rails_helper"

describe UpdateMonthlyBalances, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  after { ActiveJob::Base.queue_adapter = :inline }

  let(:transaction) { create(:transaction) }
  let(:account) { create(:account, user: transaction.user) }
  let(:formatted_dates) { [{month: transaction.date.month, year: transaction.date.year}] }

  describe "#perform" do
    it "enqueue jobs" do
      expect do
        described_class.perform_now(user: account.user, formatted_dates: formatted_dates)
      end.to have_enqueued_job(UpdateMonthBalance)

      expect do
        described_class.perform_now(user: account.user, formatted_dates: formatted_dates)
      end.to have_enqueued_job(UpdateCategoryMonthlyBalances)
    end
  end
end
