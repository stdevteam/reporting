class CreateSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :slots do |t|
      t.date :begin_at
      t.date :end_at
      t.references :location, index: true, foreign_key: true
      t.references :purchase, index: true, foreign_key: true

      t.timestamps
    end
  end
end
