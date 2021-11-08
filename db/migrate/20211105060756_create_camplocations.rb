class CreateCamplocations < ActiveRecord::Migration[6.1]
  def change
    create_table :camplocations do |t|
      t.references :camp, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
