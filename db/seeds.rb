# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Room.create([{room_number: '101', room_capacity: '2', roomtype: 'Double'}])
Room.create([{room_number: '102', room_capacity: '1', roomtype: 'Single'}])
Room.create([{room_number: '103', room_capacity: '1', roomtype: 'Single'}])
Room.create([{room_number: '104', room_capacity: '2', roomtype: 'Family'}])
Available.create([{starting_date: '09/09/2018', ending_date: '09/10/2018', room_id: '1'}])
Reservation.create([{checkin_date: '11/09/2018', checkout_date: '14/09/2018', room_id: '1'}])
Reservation.create([{checkin_date: '20/09/2018', checkout_date: '24/09/2018', room_id: '1'}])
Available.create([{starting_date: '10/08/2018', ending_date: '10/11/2018', room_id: '5'}])
Reservation.create([{checkin_date: '11/09/2018', checkout_date: '14/09/2018', room_id: '5'}])
Reservation.create([{checkin_date: '20/09/2018', checkout_date: '24/09/2018', room_id: '5'}])