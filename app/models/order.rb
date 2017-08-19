class Order < ApplicationRecord
  belongs_to :user
  has_one :shipment
  has_one :payment

  def order_number
    @num = 10000000
    @num+=1
  end
end
