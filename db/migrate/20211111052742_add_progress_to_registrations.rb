class AddProgressToRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :registrations, :progress, :integer
    add_column :registrations, :submitted, :boolean
  end
end
