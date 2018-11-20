class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer     :quantity, default: 1
      t.references  :item, foreign_key: true
      t.references  :user, foreign_key: true
      t.references  :purchased_item, default: nil, foreign_key: true
    end
  end
end
