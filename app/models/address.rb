class Address < ApplicationRecord
  belongs_to :user
  ADDRESS_ATTRIBUTES = %i(first_name last_name address city zip country phone)

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, format: { with: /\A[A-Za-z]{0,49}\z/ }
  validates :city, :country, format: { with: /\A[A-Za-z\s]{0,49}\z/ }
  validates :address, format: { with: /\A[-A-Za-z\s\d,]{0,49}\z/ }
  validates :zip, format: { with: /\A[0-9]{0,10}\z/ }
  validates :phone, format: { with: /\A[+]?\d+\z/ }
  validates_length_of :phone, maximum: 15

end
