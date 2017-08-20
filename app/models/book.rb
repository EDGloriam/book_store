class Book < ApplicationRecord
  has_one :dimension
  has_and_belongs_to_many :authors
  has_many :reviews

  FILTERS_LIST =  [nil, 'Mobile Development', 'Photo', 'Web Design']

  scope :section, -> (section) { where section: section }
end
