class UpdateMonthlyBalances < ApplicationJob
  def perform(user:, formatted_dates: [])
    # TODO use batch
    formatted_dates.each do |formatted_date|
      UpdateMonthBalance.perform_later(
        account: user.accounts.first,
        month: formatted_date[:month],
        year: formatted_date[:year]
      )
      UpdateCategoryMonthlyBalances.perform_later(
        account: user.accounts.first,
        month: formatted_date[:month],
        year: formatted_date[:year])
    end
  end
end
