# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryMonthlyStat, type: :model do
  describe "relations" do
    it { is_expected.to belong_to(:account).optional(false) }
  end

  describe "validations" do
    # it { is_expected.to validate_uniqueness_of(:account).scoped_to(:category, :month, :year) }
    it { is_expected.to validate_numericality_of(:year) }
    it { is_expected.to validate_inclusion_of(:month).in_range(1..12) }
  end
end
