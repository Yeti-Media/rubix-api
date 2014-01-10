class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end
    remove_column :patterns, :category
    add_column :patterns, :category_id, :integer
  end
end
