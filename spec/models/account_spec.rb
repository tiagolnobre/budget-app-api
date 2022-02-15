# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account, type: :model do
  describe "relations" do
    it { is_expected.to have_many(:transactions) }
    it { is_expected.to have_many(:monthly_stats) }
    it { is_expected.to have_many(:category_monthly_stats) }
    it { is_expected.to belong_to(:user).optional(false) }
  end
end
