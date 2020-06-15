class AddIndexToCategoryMonthlyStats < ActiveRecord::Migration[5.2]
  def change
    add_index :category_monthly_stats, :category, unique: true
  end
end
