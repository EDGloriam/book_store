class CreateAuthorBooks < ActiveRecord::Migration[5.0]
  def change
    rename_table :authors_books, :author_books
  end
end
