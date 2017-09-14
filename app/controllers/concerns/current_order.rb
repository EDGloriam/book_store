module CurrentOrder
  extend ActiveSupport::Concern

    private

      # def set_order
      #   puts "START SET Order==========="
      #   # debugger
      #   if cookies[:order_id].present?
      #     puts '==cookie======== 1========='
      #     @order = Order.find_by(id: cookies[:order_id].to_i)
      #   elsif (current_user && order_in_progress.present?)
      #     puts '===user======= 2========='
      #     @order = order_in_progress
      #   else
      #     puts '==new_order======== 3========='
      #     @order = Order.create
      #     cookies[:order_id] = @order.id
      #   end
      # end

      # def order_in_progress
      #   current_user.orders.where(order_status: 'in_progress')
      # end
end