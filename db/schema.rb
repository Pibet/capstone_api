# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_27_050000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "room_bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.string "booking_code", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "purpose", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_code"], name: "idx_room_bookings_unique_code", unique: true
    t.index ["room_id", "status", "start_time"], name: "idx_room_bookings_schedule_lookup"
    t.index ["room_id"], name: "index_room_bookings_on_room_id"
    t.index ["user_id"], name: "index_room_bookings_on_user_id"
    t.check_constraint "end_time > start_time", name: "chk_room_bookings_valid_period"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "capacity", null: false
    t.boolean "available", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", null: false
    t.index ["code"], name: "idx_rooms_unique_code", unique: true
    t.check_constraint "capacity > 0", name: "chk_rooms_positive_capacity"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "role", default: "student", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "idx_users_unique_email", unique: true
  end

  add_foreign_key "room_bookings", "rooms"
  add_foreign_key "room_bookings", "users"
end
