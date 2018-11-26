class CreateFoodTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :name
      t.timestamps
    end
    create_table :features do |t|
      t.references :item, foreign_key: true
      t.references :type, foreign_key: true
      t.timestamps
    end
  end
end
