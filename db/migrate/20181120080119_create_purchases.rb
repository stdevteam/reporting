class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.string :referrer
      t.float :purchased_at_price

      t.timestamps
    end
  end
end
