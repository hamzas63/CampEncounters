class ChangeDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :registrations, :submitted, 0
  end
end
