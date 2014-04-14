class AddThirdPartyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :third_party_id, :string
    add_index :users, :third_party_id
  end
end
