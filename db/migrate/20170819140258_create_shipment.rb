class CreateShipment < ActiveRecord::Migration[5.0]
  def change
    create_table :shipments do |t|
      t.string :method
      t.references :order, foreign_key: true
    end
  end
end
