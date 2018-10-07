class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer  :room_number
      t.integer  :room_capacity
      t.string   :roomtype

      t.timestamps
    end
  end
end
