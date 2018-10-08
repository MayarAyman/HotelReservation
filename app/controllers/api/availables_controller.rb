module Api
	 class AvailablesController < ApplicationController
          

          #Getting all availabilities
	 	  def index
            
               @availables= Room.joins(:reservations,:availables)
                     .select('rooms.id,rooms.room_capacity,rooms.room_number, availables.starting_date, availables.ending_date, reservations.checkin_date , reservations.checkout_date')
                     .where("reservations.room_id = availables.room_id")
                     .order('id, reservations.checkin_date')

         i=0 
         id=@availables[0].id
         room_number=@availables[0].room_number
         room_capacity=@availables[0].room_capacity
         number_of_availables= Room.joins(:availables).size+@availables.length
         starting_date = @availables[0].starting_date;
         last_available_date=""
         json = { "data" => []}
              
            #iterates  
             number_of_availables.times do  
            puts i
            if i < @availables.length
                 if id == @availables[i].id
                last_available_date =@availables[i].ending_date
                ending_date= @availables[i].checkin_date;
              json["data"].push({:id =>id, :room_number =>room_number ,:room_capacity => room_capacity,:available_date_start =>starting_date ,:available_date_end =>ending_date})
              starting_date =@availables[i].checkout_date;
                   
               else
                
                  json["data"].push({:id =>id, :room_number =>room_number,:room_capacity => room_capacity, :available_date_start =>starting_date ,:available_date_end =>last_available_date})
                  id=@availables[i].id
                  room_number =@availables[i].room_number
                  room_capacity =@availables[i].room_capacity
                  starting_date=@availables[i].starting_date;
                   i=i-1  
                end 
                     i=i+1  
                     else
                    json["data"].push({:id =>id,:room_number =>room_number,:room_capacity => room_capacity, :available_date_start =>starting_date ,:available_date_end =>last_available_date})
                   end 
               end 
        
             render json: {status: 'SUCCESS', message: 'Loaded All Availabilities',data:json}, status: :ok
      
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