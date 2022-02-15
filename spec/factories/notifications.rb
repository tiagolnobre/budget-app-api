# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { "" }
    params { "" }
    read_at { "2022-02-03 23:33:53" }
  end
end
