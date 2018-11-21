class CreateSlotVariations < ActiveRecord::Migration[5.0]
  def change
    create_table :slot_variations do |t|
      t.float :price
      t.references :slot, index: true, foreign_key: true
      t.references :variation, index: true, foreign_key: true

      t.timestamps
    end
  end
end
