class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :city
      t.string :address
      t.integer :price_per_night
      t.string :room_type
      t.integer :no_of_guest
      t.string :name
      t.string :description
      t.json :avatars

      t.timestamps null: false
    end
  end
end
