class OrdersController < ApplicationController
  def index
  end

  def new
  end

  def create
    puts "========params.inspect=========="
    @user = current_user
    @order = @user.orders.create
    @order[:number] = generate_order_number
    @order.save

    redirect_to :back
  end

  def update
  end

  def destroy
  end

  private

    def generate_order_number
      "R#{(@order[:id]+100550000)}"
    end
end
