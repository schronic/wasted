class AddColumnsToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category, :string
    add_column :items, :type, :string
  end
end
