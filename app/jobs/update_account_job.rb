class UpdateCareersJob < ApplicationJob
  def perform(user:)
    account = Account.find_or_initialize_by(user: user)
    account.positive_balance = user.transactions.positive_sum
    account.negative_balance = user.transactions.negative_sum
    account.save!
  end
end
