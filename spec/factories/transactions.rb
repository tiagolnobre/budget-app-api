# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :user, factory: :user
    date { Date.current }
    description { Faker::Bank.name }
    amount { 100 }
    category { %w[bills eating_out groceries atm healthcare income general].sample(1).first }
  end
end
