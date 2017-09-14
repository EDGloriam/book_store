class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :set_order
  # before_action :set_order

  def set_order
    puts "=============start SET ORDER ============"
    if (current_user && order_in_progress.present?)
      @order = order_in_progress[0]
      cookies[:order_id] = @order.id
    elsif cookies[:order_id].present?
      @order = Order.find_by(id: cookies[:order_id].to_i)
    else
      @order = Order.create
      cookies[:order_id] = @order.id
    end
  end

  def order_in_progress
    current_user.orders.where(order_status: 'in_progress')
  end




  def after_sign_in_path_for(resource)
    set_order
    @order.update_attributes(user_id: current_user.id)
    root_path
  end

  def after_sign_out_path_for(resource)
    puts "==========LOGOUT========="
    cookies.delete( :order_id)
    root_path
  end

end
