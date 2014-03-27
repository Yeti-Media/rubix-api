class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :file
      t.string :label
      t.integer :user_id

      t.timestamps
    end
  end
end
