class Room < ApplicationRecord
	validates :room_number, presence: true
	has_many :reservations
	has_many :availables
end
