class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance, :negative_balance, :positive_balance

  def balance
    object.negative_balance + object.positive_balance
  end
end
