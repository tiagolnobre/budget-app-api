# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.text :description
      t.float :negative_balance
      t.float :positive_balance

      t.timestamps
    end
  end
end
