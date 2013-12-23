class AddAidToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :aid, :string
    add_index :patterns, :aid
  end
end
