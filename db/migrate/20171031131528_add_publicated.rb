class AddPublicated < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :publicated, :string
  end
end
