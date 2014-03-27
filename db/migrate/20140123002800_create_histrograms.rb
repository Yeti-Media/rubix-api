class CreateHistrograms < ActiveRecord::Migration
  def change
    create_table :histrograms do |t|
      t.belongs_to :pattern, index: true
      t.text :gray
      t.text :color
      t.text :hsv
      t.timestamps
    end
  end
end
