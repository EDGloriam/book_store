module ApplicationHelper

   def prepare_for_view(authors)
    # return authors[0].name if authors.size == 1
    # return authors.map { |author| "#{author.name}" }.join(', ') if authors.size > 1
    # 'error from app_helper.rb'
    return authors[0].name if authors.size == 1
    authors.map { |author| "#{author.name}" }.join(', ')
  end

  def books_in_cart
    return 0 unless cookies[:order_id]
    order = Order.find_by(id: cookies[:order_id])
    count = order.order_items.collect { |item| item.quantity }.sum
    "<span class='shop-quantity'>#{count}</span>".html_safe unless count.zero?
  end
end
