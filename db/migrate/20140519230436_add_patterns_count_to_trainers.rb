class AddPatternsCountToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :patterns_count, :integer, default: 0
  end
end
