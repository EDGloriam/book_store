class Delivery < ApplicationRecord
  has_one :order

  #Needs for Active Admin
  def display_name
  end
end
