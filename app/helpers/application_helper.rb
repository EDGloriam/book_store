module ApplicationHelper

   def prepare_for_view(authors)
    return authors[0].name if authors.size == 1
    return authors.map { |author| "#{author.name}" }.join(', ') if authors.size > 1
    'error from books_helper.rb'
  end

  def books_in_cart
    return 0 unless cookies[:order_id]
    # order.order_items.collect { |item| item.quantity }.sum
    Order.find_by(id: cookies[:order_id]).order_items.count
    # order.order_items.count
  end
end
