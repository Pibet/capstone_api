class User < ApplicationRecord
  has_many :room_bookings, dependent: :destroy
  has_many :rooms, through: :room_bookings

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, presence: true, inclusion: { in: %w[student admin] }
end