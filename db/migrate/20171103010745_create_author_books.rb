class CreateAuthorBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :author_books do |t|
      t.references :author, foreign_key: true, index: true
      t.references :book, foreign_key: true, index: true
    end
    drop_table :authors_books
  end
end
