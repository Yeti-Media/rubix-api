class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end
    add_column :patterns, :category_id, :integer
  end
end
