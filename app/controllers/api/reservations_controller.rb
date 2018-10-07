module Api
	 class ReservationsController < ApplicationController

	 	  def index
        reservations = Reservation.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded Reservations',data:reservations}, status: :ok
          end
	 end
end	