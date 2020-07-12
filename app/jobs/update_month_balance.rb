# frozen_string_literal: true

class UpdateMonthBalance < ApplicationJob
  def perform(account:, month:, year:)
    monthly_stat = MonthlyStat.find_or_initialize_by(account: account, month: month, year: year)
    transactions = account.user.transactions.month(month).year(year)

    monthly_stat.positive_balance = transactions.positive_sum
    monthly_stat.negative_balance = transactions.negative_sum
    monthly_stat.save!
  end
end
