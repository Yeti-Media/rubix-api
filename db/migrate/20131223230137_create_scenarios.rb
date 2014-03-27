class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.column :file, :oid
      t.text :result
      t.text :descriptors
      t.string :url

      t.timestamps
    end
  end
end
