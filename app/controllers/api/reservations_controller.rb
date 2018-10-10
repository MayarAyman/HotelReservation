module Api
	 class ReservationsController < ApplicationController

	 	
          def availableReservations
          	  available_rooms= Room.joins(:availables,:reservations)
                     .select('rooms.id,rooms.room_capacity,rooms.roomtype,rooms.room_number')
                     .where("availables.starting_date < ? AND availables.ending_date > ? AND rooms.room_capacity = ?", params[:start_date], params[:end_date], params[:capacity])
                    
        reserved_rooms= available_rooms.joins(:reservations)
        .select( 'rooms.id')
        .where("? BETWEEN reservations.checkin_date AND reservations.checkout_date  OR  ? BETWEEN reservations.checkin_date AND reservations.checkout_date", params[:start_date],params[:end_date])
      
       ids=reserved_rooms.pluck(:id)
      available_reservations= available_rooms.where.not(id: ids).uniq

        render json: {status: 'SUCCESS', message: 'Loaded Reservations',data:available_reservations}, status: :ok
          end
	 end
end	