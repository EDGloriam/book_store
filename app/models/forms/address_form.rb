class AddressForm
  include Virtus.model
  include ActiveModel::Model

  attribute :zip_code, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, String
  attribute :phone, Integer

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, format: { with: /\A[A-Za-z]{0,49}\z/ }
  validates :city, :country, format: { with: /\A[A-Za-z\s]{0,49}\z/ }
  validates :address, format: { with: /\A[-A-Za-z\s\d,]{0,49}\z/ }
  validates :zip, format: { with: /\A[0-9]{0,5}\z/ }
  validates :phone, format: { with: /\A[+]?\d+\z/ }
  validates :phone, length: { is: 15 }

end
