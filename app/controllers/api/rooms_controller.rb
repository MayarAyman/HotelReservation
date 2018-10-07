module Api
   class RoomsController < ApplicationController
       
       #Retrieving all Rooms
       def index
        rooms = Room.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded Rooms',data:rooms}, status: :ok
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
        room = Room.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded Rooms',data:room}, status: :ok
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