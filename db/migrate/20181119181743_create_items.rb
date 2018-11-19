class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.datetime :expiration
      t.integer :price
      t.datetime :pickup_time
      t.string :picture
      t.integer :quantity

      t.timestamps
    end
  end
end
