class CreditCard < ApplicationRecord
  has_one :order
  validates :number, :name, :mmyy, :cvv, presence: true
  validates_format_of :number, with: %r{\A\d{16}\z}
  validates_format_of :name, with: %r{\A[a-zA-Z\s]{0,49}\z}
  validates_format_of :mmyy, with: %r{\A(0[1-9]|10|11|12)\/\d\d\z}
  validates_length_of :cvv, in: 3..4
  validates :cvv, numericality: { only_integer: true }

  has_one :order

end
