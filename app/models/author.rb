class Author < ApplicationRecord
  has_many :author_books, dependent: :nullify
  has_many :books, through: :author_books
  # accepts_nested_attributes_for :books


end
