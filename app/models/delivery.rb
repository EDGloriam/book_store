class Delivery < ApplicationRecord
  has_one :order

  def display_name
  end
end
