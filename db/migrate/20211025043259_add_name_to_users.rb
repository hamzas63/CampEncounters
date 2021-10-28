class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string
    add_column :users, :type, :string
  end
end
