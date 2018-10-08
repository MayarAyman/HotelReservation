module Api
   class RoomsController < ApplicationController
       
       #Retrieving all Rooms, for showing availability choose true
       def index

        if params[:show_availabilty] == "true"

               @rooms= Room.joins(:reservations,:availables)
                     .select('rooms.id, availables.starting_date, availables.ending_date, reservations.checkin_date , reservations.checkout_date')
                     .where("reservations.room_id = availables.room_id")
                     .order('id, reservations.checkin_date')

         i=0 
         id=@rooms[0].id
         number_of_rooms= Room.joins(:availables).size+@rooms.length
         starting_date = @rooms[0].starting_date;
         last_available_date=""
         json = { "data" => []}
              
            #iterates  
             number_of_rooms.times do  
            puts i
            if i < @rooms.length
                 if id == @rooms[i].id
                last_available_date =@rooms[i].ending_date
                ending_date= @rooms[i].checkin_date;
              json["data"].push({:id =>id, :available_date_start =>starting_date ,:available_date_end =>ending_date})
              starting_date =@rooms[i].checkout_date;
                   
               else
                
                  json["data"].push({:id =>id, :available_date_start =>starting_date ,:available_date_end =>last_available_date})
                  id=@rooms[i].id
                  starting_date=@rooms[i].starting_date;
                   i=i-1  
                end 
                     i=i+1  
                     else
                    json["data"].push({:id =>id, :available_date_start =>starting_date ,:available_date_end =>last_available_date})
                   end 
               end 
        
             render json: {status: 'SUCCESS', message: 'Loaded Available Rooms',data:json}, status: :ok
      
        else
              rooms = Room.order('created_at DESC');
              render json: {status: 'SUCCESS', message: 'Loaded Rooms',data:rooms}, status: :ok
        end 
          
       end
       
       #Add a new Room
       def create
        room = Room.new(room_params)

        if room.save
         render json: {status: 'SUCCESS', message: 'A New Room Is Saved',data:room}, status: :ok
         else 
          render json: {status: 'ERROR', message: 'Room is not saved',data:room.errors}, status: :unprocessable_entity
        end 

       end
        
      #Return a specific Room
       def show
         if params[:show_availabilty] == "false"
        room = Room.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded Rooms',data:room}, status: :ok
      else
      end

       end



        #Updates a specific room
        def update
          room =Room.find(params[:id])
          if room.update_attributes(room_params)
            render json: {status: 'SUCCESS', message: 'Updated',data:room}, status: :ok
          else
            render json: {status: 'ERROR', message: 'Not Updated',data:room.errors}, status: :unprocessable_entity
        
          end
         end
 
      private
      def room_params
        params.permit(:room_number , :room_capacity , :roomtype)
      end

    end
end