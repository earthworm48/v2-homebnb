class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :start_date
      t.string :end_date
      t.integer :no_of_guest

      t.timestamps null: false
    end
  end
end
