class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      t.string :name
      t.string :camp_type
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.date :registartion_date

      t.timestamps
    end
  end
end
