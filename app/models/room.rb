class Room < ApplicationRecord
  has_many :room_bookings, dependent: :restrict_with_error
  has_many :users, through: :room_bookings

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end