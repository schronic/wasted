class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.references :purchase, foreign_key: true
    end
  end
end
