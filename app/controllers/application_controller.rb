class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  # helper_method :guest?
  # helper_method :init_order

  # def guest?
  #   if current_user
  #     # session[:test_u] = current_user.id
  #     false
  #   else
  #     # session[:test_u] = "guest"
  #     true
  #   end
  # end
  def current_order
    Order.find_by(id: session[:order_id])
  end
  # def current_order
  #   Order.find_or_create_by(id: session[:order_id]) || init_order
  # end

  # def init_order
  #   if current_user
  #     current_user.orders.create
  #   else
  #     Order.create
  #   end
  # end
end
