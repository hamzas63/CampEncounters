class ChangeCamplocationsToCampLocations < ActiveRecord::Migration[6.1]
  def change
    rename_table :camplocations, :camp_locations
  end
end
