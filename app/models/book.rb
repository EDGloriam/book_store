class Book < ApplicationRecord
  has_one :dimension
  has_and_belongs_to_many :authors
end
