class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :subtotal, precision: 6, scale: 3, default: 0
      t.decimal :total, precision: 6, scale: 3, default: 0
      t.boolean :discount_applied, default: false
      t.decimal :discount_amount, precision: 6, scale: 3, default: 0
      t.integer :order_status

      t.timestamps
    end
  end
end
