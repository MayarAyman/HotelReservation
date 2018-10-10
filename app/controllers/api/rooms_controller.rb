module Api
   class RoomsController < ApplicationController
       
       #Retrieving all Rooms, for showing availability choose true
       def index

        if params[:show_availabilty] == "true"

               json = { "data" => []}
               number_of_rooms=Available.pluck(:room_id).uniq
                #loop on the number of rooms available 
                number_of_rooms.size.times do |j|

               available =  Available.where(:room_id => number_of_rooms[j])
               reservations= Reservation.where(:room_id => number_of_rooms[j])
               room =Room.where(:id => number_of_rooms[j]);
               room_number=room[0].room_number
               room_capacity=room[0].room_capacity
               room_id=number_of_rooms[j]
                k=0
                #looping on 
               available.size.times do |i|
                start_available_time=available[i].starting_date
                ending_available_time=available[i].ending_date
               
                while k < reservations.size + 1  do
               
                  if (k < reservations.size) && (reservations[k].checkin_date <  ending_available_time )
                      json["data"].push({:id =>room_id , :room_number =>room_number ,:room_capacity => room_capacity,:available_start_date =>start_available_time ,:available_end_date =>reservations[k].checkin_date})
                      start_available_time=reservations[k].checkout_date
                      k=k+1
                   else
                      json["data"].push({:id =>room_id , :room_number =>room_number ,:room_capacity => room_capacity,:available_start_date =>start_available_time ,:available_end_date =>ending_available_time})
                      break;
                  end

                end
                 
               end
              end
              remaining_rooms_number= Room.where.not(id: number_of_rooms)
              remaining_rooms_number.size.times do |i|
                 json["data"].push({:id => remaining_rooms_number[i].id, :room_number =>remaining_rooms_number[i].room_number ,:room_capacity => remaining_rooms_number[i].room_capacity,:available => "No Avalibility Dates" })
            
            end
             render json: {status: 'SUCCESS', message: 'Loaded all Rooms with Avalibilities',data: json}, status: :ok
      
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
            json = { "data" => []}
               available =  Available.where(:room_id =>params[:id])
               reservations= Reservation.where(:room_id =>params[:id])
               room =Room.where(:id => params[:id])

               room_number=room[0].room_number
               room_capacity=room[0].room_capacity
               room_id=room[0].id
                k=0
                #looping on 
               available.size.times do |i|
                start_available_time=available[i].starting_date
                ending_available_time=available[i].ending_date
               
                while k < reservations.size + 1  do
                  if (k < reservations.size) && (reservations[k].checkin_date <  ending_available_time )
                      json["data"].push({:id =>room_id , :room_number =>room_number ,:room_capacity => room_capacity,:available_start_date =>start_available_time ,:available_end_date =>reservations[k].checkin_date})
                      start_available_time=reservations[k].checkout_date
                      k=k+1
                   else
                      json["data"].push({:id =>room_id , :room_number =>room_number ,:room_capacity => room_capacity,:available_start_date =>start_available_time ,:available_end_date =>ending_available_time})
                      break;
                  end
                      
                end
               end
               render json: {status: 'SUCCESS', message: 'Loaded Required Room',data: json}, status: :ok
        #end of showparam if       
      end
 #end of def
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