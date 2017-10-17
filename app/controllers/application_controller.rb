class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :set_order

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def set_order
    if (current_user && order_in_progress.present?)
      @order = order_in_progress[0]
      # set_cookie
    elsif cookies[:order_id].present?
      @order = Order.find_by(id: cookies[:order_id].to_i)
      # attach_order
    else
      @order = Order.create
      # @order.save
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
    @order.update_attributes(user_id: current_user.id) if current_user #added 'if current_user' because Active Admin complained
  end

  def after_sign_in_path_for(resource)
    set_order
    attach_order
    root_path
  end

  # def after_sign_out_path_for(resource)
  #   root_path
  # end


end
