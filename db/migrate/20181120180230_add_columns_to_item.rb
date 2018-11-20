class AddColumnsToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category, :string
    add_column :items, :food_type, :string
  end
end
