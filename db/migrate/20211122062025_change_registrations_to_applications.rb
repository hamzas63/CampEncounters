class ChangeRegistrationsToApplications < ActiveRecord::Migration[6.1]
  def change
    rename_table :registrations, :applications
  end
end
