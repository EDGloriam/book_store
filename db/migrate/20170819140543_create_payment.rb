class CreatePayment < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :number
      t.date :mm_yy
      t.integer :cvv
      t.references :order, foreign_key: true
    end
  end
end
