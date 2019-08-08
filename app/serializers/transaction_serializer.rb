# frozen_string_literal: true

class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :description, :amount, :category, :date
end
