module ApplicationHelper

  def selected_menu_item(value)
    return 'All' unless value
    value.to_s.gsub('_', ' ').capitalize
  end

  def generate_link_for_category(category, its_header_menu = false)
    content_tag(:a, nil,
      href: books_path(category: "#{category.nil? ? '' : category.id}" ),
      class: "#{its_header_menu ? 'collapse-link' : 'filter-link'}") do
        concat("#{category.nil? ? 'All' : category.name}")
        concat(content_tag(:span, "#{category_size(category)}", class: 'badge general-badge')) unless its_header_menu
      end
  end

  def prepare_for_view(authors)
    return authors[0].name if authors.size == 1
    authors.map { |author| "#{author.name}" }.join(', ')
  end

  def books_in_cart
    order =  current_user.present? ? current_user.orders.in_progress[0] : Order.find_by(id: cookies[:order_id])
    return unless order
    count = order.order_items.collect { |item| item.quantity }.sum
    "<span class='shop-quantity'>#{count}</span>".html_safe unless count.zero?
  end
end
