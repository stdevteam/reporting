class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :street_address
      t.string :country
      t.string :city
      t.string :zip_code

      t.timestamps
    end
  end
end
