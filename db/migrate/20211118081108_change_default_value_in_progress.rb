class ChangeDefaultValueInProgress < ActiveRecord::Migration[6.1]
  def change
    change_column_default :registrations, :progress, 0
  end
end
