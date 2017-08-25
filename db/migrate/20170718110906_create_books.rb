class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :photo
      t.string :description
      t.decimal :price, precision: 6, scale: 2
      t.boolean :active

      t.timestamps
    end
  end
end
