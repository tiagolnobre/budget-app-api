# frozen_string_literal: true

class UserEmailAndUsernameIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
