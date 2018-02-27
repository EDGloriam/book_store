class RemovePublication < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :publication, :string
  end
end
