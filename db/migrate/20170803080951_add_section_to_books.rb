class AddSectionToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :section, :string
  end
end
