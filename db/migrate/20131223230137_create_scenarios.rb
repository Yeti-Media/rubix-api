class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.column :file, :oid
      t.text :result
      t.xml :descriptors
      t.string :url
      t.integer :category_id
      t.timestamps
    end
  end
end
