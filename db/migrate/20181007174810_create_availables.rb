class CreateAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :availables do |t|
      t.date :starting_date
      t.date :ending_date

      t.timestamps
    end
  end
end
