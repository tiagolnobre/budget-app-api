class AddIndexToMonthlyStats < ActiveRecord::Migration[5.2]
  def change
    remove_index :monthly_stats, %i[account]
    add_index :monthly_stats, %i[account month year], unique: true
  end
end
