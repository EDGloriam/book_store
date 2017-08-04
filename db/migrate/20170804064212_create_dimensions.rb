class CreateDimensions < ActiveRecord::Migration[5.0]
  def change
    create_table :dimensions do |t|
      t.float :h
      t.float :w
      t.float :d
      t.references :book, index: true, foreign_key: true
      t.timestamps
    end
  end
end
