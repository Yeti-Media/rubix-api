class AddTrainerIdToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :trainer_id, :integer
    add_column :patterns, :position, :integer
  end
end
