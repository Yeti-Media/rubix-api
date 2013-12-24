class ChangePatternsLabelToText < ActiveRecord::Migration
  def up
    change_column :patterns , :label, :text
  end
  
  def down
    change_column :patterns , :label, :string
  end
end
