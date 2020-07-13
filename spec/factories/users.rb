# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { '123qweasd' }
    password_confirmation { '123qweasd' }
  end
end
