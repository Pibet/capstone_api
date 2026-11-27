class RoomBooking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :booking_code, presence: true, uniqueness: true
  validates :start_time, :end_time, :purpose, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }
  validate :end_time_must_be_after_start_time

  def approve_booking!(simulate_failure: false)
    ActiveRecord::Base.transaction do
      update!(status: "approved")

      room.room_bookings
          .where(status: "pending")
          .where.not(id: id)
          .where("start_time < ? AND end_time > ?", end_time, start_time)
          .update_all(status: "rejected", updated_at: Time.current)

      raise ActiveRecord::Rollback, "Simulasi gagal di tengah transaksi" if simulate_failure

      room.update!(available: false)
    end
  end

  private

  def end_time_must_be_after_start_time
    return if start_time.blank? || end_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "harus lebih akhir dari waktu mulai")
    end
  end
end