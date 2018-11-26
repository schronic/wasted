class ChangeDistanceToDistanceToLocation < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :distance, :distance_location
  end
end
