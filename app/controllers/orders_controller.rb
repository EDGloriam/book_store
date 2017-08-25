class OrdersController < ApplicationController


  private

    def generate_order_number
      "R#{(@order_item[:id]+100550000)}"
    end
end
