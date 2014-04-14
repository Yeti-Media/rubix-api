class AddAccountTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string
    add_index :users, :account_type
    add_index :users, [:access_token, :account_type]
  end
end
