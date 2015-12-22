class ChangeColumnDefaultOfImageUrl < ActiveRecord::Migration
  def change
    change_column_default :users, :image_url, 'user-pic.png'
  end
end