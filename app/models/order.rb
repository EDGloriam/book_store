class Order < ApplicationRecord
  belongs_to :user
  has_one :shipment
  has_one :payment

end
