class AddAidToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :aid, :string
  end
end
