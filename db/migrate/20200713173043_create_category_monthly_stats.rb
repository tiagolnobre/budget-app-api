# frozen_string_literal: true

class CreateCategoryMonthlyStats < ActiveRecord::Migration[6.0]
  def change
    create_table :category_monthly_stats, id: :uuid do |t|
      t.references :account, type: :uuid, foreign_key: true, index: true
      t.integer :month, required: true
      t.integer :year, required: true
      t.text :category, required: true
      t.float :negative_balance, default: 0
      t.float :positive_balance, default: 0

      t.timestamps
    end

    add_index :category_monthly_stats, :month
    add_index :category_monthly_stats, :year
    add_index :category_monthly_stats, %i[account_id category month year], name: "index_cms_on_acount_month_year_cat", unique: true
  end
end
