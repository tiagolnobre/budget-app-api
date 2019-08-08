class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.belongs_to :user, index: true
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
