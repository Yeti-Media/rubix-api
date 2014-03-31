class CreateDescriptors < ActiveRecord::Migration
  def change
    create_table :descriptors do |t|
      t.xml :body
      t.belongs_to :pattern, index: true

      t.timestamps
    end
  end
end
