module Api
	 class AvailablesController < ApplicationController
          

          #Getting all availabilities
	 	  def index
            
               json = { "data" => []}
               number_of_rooms=Available.pluck(:room_id).uniq
                #loop on the number of rooms available 
                number_of_rooms.size.times do |j|

               available =  Available.where(:room_id => number_of_rooms[j])
               reservations= Reservation.where(:room_id => number_of_rooms[j])
               room_id=number_of_rooms[j]
                k=0
                #looping on 
               available.size.times do |i|
                start_available_time=available[i].starting_date
                ending_available_time=available[i].ending_date
               
                while k < reservations.size + 1  do
               
                  if (k < reservations.size) && (reservations[k].checkin_date <  ending_available_time )
                      json["data"].push({:id =>room_id ,:available_start_date =>start_available_time ,:available_end_date =>reservations[k].checkin_date})
                      start_available_time=reservations[k].checkout_date
                      k=k+1
                   else
                      json["data"].push({:id =>room_id ,:available_start_date =>start_available_time ,:available_end_date =>ending_available_time})
                      break;
                  end

                end
                 
               end

              end
        
             render json: {status: 'SUCCESS', message: 'Loaded Available Rooms',data: json}, status: :ok
      
          end

         #Updating an Availability
          def update

          available =Available.find(params[:id])

          if available.update_attributes(available_params)
            render json: {status: 'SUCCESS', message: 'Updated',data:available}, status: :ok
          else
            render json: {status: 'ERROR', message: 'Not Updated',data:available.errors}, status: :unprocessable_entity
          end
         end
        
         #Add a new Availability
       def create
        available =Available.new(available_params)

        if available.save
         render json: {status: 'SUCCESS', message: 'A New Availability Is Saved',data:available}, status: :ok
         else 
          render json: {status: 'ERROR', message: 'Availability is not saved',data:available.errors}, status: :unprocessable_entity
        end 

       end

      private
      def available_params
        params.permit(:starting_date , :ending_date , :room_id)
      end


	 end
end	