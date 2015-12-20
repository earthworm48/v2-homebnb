class AddListingToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :listing, index: true, foreign_key: true
  end
end
