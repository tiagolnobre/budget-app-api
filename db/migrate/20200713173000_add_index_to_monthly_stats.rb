# frozen_string_literal: true

class AddIndexToMonthlyStats < ActiveRecord::Migration[6.0]
  def change
    add_index :monthly_stats, %i[account_id month year], unique: true
  end
end
