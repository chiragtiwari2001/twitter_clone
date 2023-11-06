class AddOmniauthToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fullname, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :avavtar_url, :string
  end
end
