module Api
	 class AvailablesController < ApplicationController
          

          #Getting all availabilities
	 	  def index
             available = Available.order('created_at DESC');
            render json: {status: 'SUCCESS', message: 'Loaded availabilities',data:available}, status: :ok
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