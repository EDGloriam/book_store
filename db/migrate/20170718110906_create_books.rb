class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :photo
      t.string :description
      t.decimal :price, precision: 6, scale: 2
      t.boolean :active
      t.decimal :height, precision: 4, scale: 1
      t.decimal :weight, precision: 4, scale: 1
      t.decimal :depth, precision: 4, scale: 1
      t.timestamps
    end
  end
end
