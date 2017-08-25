class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    Order.find_or_create_by(id: 1, order_status_id: 1)
  end
end
