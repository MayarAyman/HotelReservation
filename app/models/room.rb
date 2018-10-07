class Room < ApplicationRecord
	validates :room_number, presence: true
	has_many :reservation
	has_many :available
end
