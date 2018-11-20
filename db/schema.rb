# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_20_145217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "expiration", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "price"
    t.datetime "pickup_time", default: -> { "CURRENT_TIMESTAMP" }
    t.string "picture"
    t.integer "quantity", default: 1
    t.bigint "user_id"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.string "food_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_price"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "purchased_items", force: :cascade do |t|
    t.integer "item_purchase_price"
    t.integer "item_purchase_quantity"
    t.string "item_purchase_name"
    t.text "item_purchase_description"
    t.datetime "item_purchase_expiration"
    t.datetime "item_purchase_pickup_time"
    t.string "item_purchase_picture"
    t.bigint "item_id"
    t.bigint "order_id"
    t.index ["item_id"], name: "index_purchased_items_on_item_id"
    t.index ["order_id"], name: "index_purchased_items_on_order_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.bigint "item_id"
    t.bigint "user_id"
    t.bigint "purchased_item_id"
    t.index ["item_id"], name: "index_reservations_on_item_id"
    t.index ["purchased_item_id"], name: "index_reservations_on_purchased_item_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "username"
    t.string "avatar"
    t.string "role"
    t.boolean "subscribed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "purchased_items", "items"
  add_foreign_key "purchased_items", "orders"
  add_foreign_key "reservations", "items"
  add_foreign_key "reservations", "purchased_items"
  add_foreign_key "reservations", "users"
end
