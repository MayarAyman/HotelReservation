Rails.application.routes.draw do

 # get 'welcome/index'   
  
  #get '/rooms', to: 'room#index', as: 'button'

 # root 'welcome#index'
  namespace 'api' do
  	resources :rooms
  	resources :reservations
  	resources :availables
  end

end
