class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :set_order

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def set_order
    if (current_user && order_in_progress.present?)
      @order = order_in_progress[0]
    elsif cookies[:order_id].present?
      @order = Order.find_by(id: cookies[:order_id].to_i)
    else
      @order = Order.create
      current_user ? attach_order : set_cookie
    end
  end

  def order_in_progress
    current_user.orders.in_progress
  end

  def set_cookie
    cookies[:order_id] = @order.id
  end

  def attach_order
    #added 'if current_user' because Active Admin complained
    @order.update_attributes(user_id: current_user.id) if current_user
  end

  def after_sign_in_path_for(resource)
    set_order
    attach_order
    if cookies[:checkout]
      cookies.delete :checkout
      check_out_pages_path
    else
      root_path
    end
  end
end
