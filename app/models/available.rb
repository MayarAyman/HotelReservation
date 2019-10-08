class Available < ApplicationRecord
	validates :starting_date, presence: true
	validates :ending_time, presence: true
	belongs_to :room

end
