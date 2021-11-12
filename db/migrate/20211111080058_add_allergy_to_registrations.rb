class AddAllergyToRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :registrations, :allergy, :string
    add_column :registrations, :medicine, :string
  end
end
