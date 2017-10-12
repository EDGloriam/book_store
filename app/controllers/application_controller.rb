class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :set_order

  def set_order
    if (current_user && order_in_progress.present?)
      @order = order_in_progress[0]
      set_order_from_cookie
    elsif cookies[:order_id].present?
      @order = Order.find_by(id: cookies[:order_id].to_i)
      attach_order if current_user
    else
      @order = Order.create
      set_order_from_cookie
    end
  end

  def order_in_progress
    current_user.orders.in_progress
  end

  def set_order_from_cookie
    cookies[:order_id] = @order.id
  end

  def attach_order
    @order.update_attributes(user_id: current_user.id)
  end

  def after_sign_in_path_for(resource)
    set_order
    puts "====================AFTER SIGN IN==================="
    attach_order
    root_path
  end

  def after_sign_out_path_for(resource)
    puts "==========LOGOUT========="
    cookies.delete( :order_id)
    root_path
  end

end
