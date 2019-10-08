class Reservation < ApplicationRecord
	validates :checkin_date, presence: true
	validates :checkout_date, presence: true
	belongs_to :room
end
