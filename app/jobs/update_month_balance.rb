class UpdateMonthBalance < ApplicationJob
  def perform(account:, month:, year:)
    monthly_stat = MonthlyStat.find_or_initialize_by(account: account, month: month, year: year)
    user = account.user
    monthly_stat.positive_balance = user.transactions.positive_sum
    monthly_stat.negative_balance = user.transactions.negative_sum
    monthly_stat.save!
  end
end
