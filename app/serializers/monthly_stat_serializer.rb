class MonthlyStatSerializer < ActiveModel::Serializer
  attributes :id, :balance, :negative_balance, :positive_balance, :month, :year

  def balance
    object.negative_balance + object.positive_balance
  end
end
