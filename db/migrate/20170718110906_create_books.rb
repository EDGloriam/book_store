class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :photo
      t.string :description
      t.string :authors
      t.float :price

      t.timestamps
    end
  end
end
