class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.boolean :used, deault: false
      t.decimal :subtotal, precision: 6, scale: 2
      t.integer :discount

      t.timestamps
    end
  end
end
