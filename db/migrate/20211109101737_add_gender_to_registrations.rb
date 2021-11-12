class AddGenderToRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :registrations, :gender, :string
    add_column :registrations, :dob, :date
    add_column :registrations, :blood_group, :string
    add_column :registrations, :occupation, :string
    add_column :registrations, :nationality, :string
    add_column :registrations, :martial_status, :string
    add_column :registrations, :confirmation_email, :string
    add_column :registrations, :weight, :integer
    add_column :registrations, :height, :string
  end
end
