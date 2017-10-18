module OrdersHelper
  def status_to_menu_item(status)
    return 'All orders' unless status
    status.to_s.gsub('_', ' ').capitalize
  end
end
