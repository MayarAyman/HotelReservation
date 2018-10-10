Rails.application.routes.draw do


  namespace 'api' do
  	resources :rooms 
  	resources :reservations do
  	      collection do
          get :availableReservations
         end
  	end
  	resources :availables
  end

end
