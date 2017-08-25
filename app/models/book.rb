class Book < ApplicationRecord
  has_one :dimension
  has_and_belongs_to_many :authors
  has_many :reviews
  has_many :order_items

  FILTERS_LIST =  [nil, 'Mobile Development', 'Photo', 'Web Design']

  default_scope { where(active: true) }
  scope :section, -> (section) { where section: section }
end
