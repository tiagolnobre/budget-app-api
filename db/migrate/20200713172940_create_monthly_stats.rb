# frozen_string_literal: true

class CreateMonthlyStats < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_stats, id: :uuid do |t|
      t.references :account, type: :uuid, foreign_key: true, index: true
      t.integer :month, required: true
      t.integer :year, required: true
      t.float :negative_balance, default: 0
      t.float :positive_balance, default: 0

      t.timestamps
    end
  end
end
