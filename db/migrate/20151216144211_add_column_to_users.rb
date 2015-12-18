class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :name, :string
    add_column :users, :url, :string
    add_column :users, :image_url, :string
    add_column :users, :authentications, :string
  end
end
