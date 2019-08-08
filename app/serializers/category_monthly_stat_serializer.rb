# frozen_string_literal: true

class CategoryMonthlyStatSerializer < ActiveModel::Serializer
  attributes :id, :category, :balance, :negative_balance, :positive_balance, :month, :year

  def balance
    object.negative_balance + object.positive_balance
  end
end
