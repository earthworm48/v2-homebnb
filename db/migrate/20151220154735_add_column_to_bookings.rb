class AddColumnToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :nonce, :string
    add_column :bookings, :amount, :integer
  end
end
