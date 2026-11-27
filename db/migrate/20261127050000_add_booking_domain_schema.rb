class AddBookingDomainSchema < ActiveRecord::Migration[8.1]
  def change
    # 1. Memperketat tabel rooms yang sudah ada dari TP6
    add_column :rooms, :code, :string, null: false
    change_column_null :rooms, :name, false
    change_column_null :rooms, :capacity, false
    change_column_default :rooms, :available, from: nil, to: true
    change_column_null :rooms, :available, false

    add_index :rooms, :code, unique: true, name: "idx_rooms_unique_code"
    add_check_constraint :rooms, "capacity > 0", name: "chk_rooms_positive_capacity"

    # 2. Membuat entitas users (peminjam & admin)
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :role, null: false, default: "student"

      t.timestamps
    end

    add_index :users, :email, unique: true, name: "idx_users_unique_email"

    # 3. Membuat entitas room_bookings (relasi users & rooms)
    create_table :room_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :booking_code, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :purpose, null: false
      t.string :status, null: false, default: "pending"

      t.timestamps
    end

    add_index :room_bookings, :booking_code, unique: true, name: "idx_room_bookings_unique_code"
    add_index :room_bookings, [:room_id, :status, :start_time], name: "idx_room_bookings_schedule_lookup"
    add_check_constraint :room_bookings, "end_time > start_time", name: "chk_room_bookings_valid_period"
  end
end