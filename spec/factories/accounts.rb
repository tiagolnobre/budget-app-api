# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    association :user, factory: :user
    negative_balance { 0.0 }
    positive_balance { 0.0 }
    description { "" }
  end
end
