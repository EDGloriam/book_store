class Author < ApplicationRecord
  has_many :author_books, dependent: :nullify
  has_many :books, through: :author_books
  validates :name, presence: true, uniqueness: true

end
