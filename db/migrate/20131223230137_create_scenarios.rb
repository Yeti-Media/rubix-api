class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :file
      t.text :result
      t.string :url

      t.timestamps
    end
  end
end
