# frozen_string_literal: true

class UpdateCategoryMonthlyBalances < ApplicationJob
  def perform(account:, month:, year:)
    transactions = account.user.transactions.month(month).year(year)

    transactions.pluck(:category).uniq.each do |category|
      category_transactions = transactions.where(category: category)

      category_monthly_stat = CategoryMonthlyStat.find_or_create_by(
        account: account,
        month: month,
        year: year,
        category: category
      )

      category_monthly_stat.positive_balance = category_transactions.positive_sum
      category_monthly_stat.negative_balance = category_transactions.negative_sum
      category_monthly_stat.save!
    end
  end
end
