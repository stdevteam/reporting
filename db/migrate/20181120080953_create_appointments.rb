class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :status

      t.references :client, index: true, foreign_key: true
      t.references :slot, index: true, foreign_key: true

      t.timestamps
    end
  end
end
