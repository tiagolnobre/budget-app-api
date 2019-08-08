# frozen_string_literal: true

class AdRemoveIndexToCategoryMonthlyStats < ActiveRecord::Migration[6.0]
  def change
    remove_index :category_monthly_stats, :category
    add_index :category_monthly_stats, :category
  end
end
