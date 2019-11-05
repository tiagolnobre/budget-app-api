class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance, :negative_balance, :positive_balance, :monthly_stats

  def balance
    object.negative_balance + object.positive_balance
  end

  has_many :monthly_stats
end
