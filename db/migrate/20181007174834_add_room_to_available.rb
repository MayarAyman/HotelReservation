class AddRoomToAvailable < ActiveRecord::Migration[5.2]
  def change
    add_reference :availables, :room, foreign_key: true
  end
end
