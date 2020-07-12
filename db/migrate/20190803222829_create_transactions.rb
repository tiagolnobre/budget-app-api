# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.date :date
      t.text :description
      t.float :amount
      t.text :category

      t.timestamps
    end

    add_index :transactions, :date
    add_index :transactions, :category
  end
end
