# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:user).optional(false) }
<<<<<<< HEAD
    it { is_expected.to have_many(:accounts).through(:user) }
=======
    it { is_expected.to have_many(:account).through(:user) }
>>>>>>> affe079... Update main.workflow
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
  end
end
