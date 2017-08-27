class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :subtotal, precision: 6, scale: 2
      t.decimal :total, precision: 6, scale: 2
      t.references :order_status, foreign_key: true

      t.timestamps
    end
  end
end
