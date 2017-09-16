class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.boolean :used, default: false
      t.decimal :discount, precision: 6, scale: 3

      t.timestamps
    end
  end
end
