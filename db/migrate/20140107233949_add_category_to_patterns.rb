class AddCategoryToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :category, :string
  end
end
