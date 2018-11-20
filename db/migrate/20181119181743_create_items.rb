class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.datetime :expiration, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :price
      t.datetime :pickup_time, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :picture
      t.integer :quantity, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
