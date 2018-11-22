class AddDistanceToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :distance, :integer
  end
end
