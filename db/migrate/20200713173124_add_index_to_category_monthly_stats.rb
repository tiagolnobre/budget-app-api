# frozen_string_literal: true

class AddIndexToCategoryMonthlyStats < ActiveRecord::Migration[6.0]
  def change
    add_index :category_monthly_stats, :category, unique: true
  end
end
