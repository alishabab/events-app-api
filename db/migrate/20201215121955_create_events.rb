class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :creator_id
      t.text :description
      t.timestamps
    end
  end
end
