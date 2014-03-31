class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.column :xml_file, :oid
      t.column :if_file, :oid
      t.references :user, index: true
      t.timestamps
    end
  end
end
