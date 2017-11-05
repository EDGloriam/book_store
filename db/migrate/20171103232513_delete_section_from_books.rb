class DeleteSectionFromBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :section
  end
end
