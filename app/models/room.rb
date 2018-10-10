class Room < ApplicationRecord
	validates :room_number, presence: true
	validates :room_number, presence: true
	validates :room_number, presence: true
	
	has_many :reservations , dependent: :destroy
	has_many :availables , dependent: :destroy
end
