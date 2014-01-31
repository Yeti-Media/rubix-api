class CreateDescriptors < ActiveRecord::Migration
  def change
    create_table :descriptors do |t|
      t.text :body
      t.belongs_to :pattern, index: true

      t.timestamps
    end
  end
end
