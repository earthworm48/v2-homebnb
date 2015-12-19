class ChangeColumnDefaultInUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :image_url, '/assets/user-pic.png'
  end
end