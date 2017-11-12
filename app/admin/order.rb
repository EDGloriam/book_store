ActiveAdmin.register Order do
  permit_params order: [:order_status]

  scope("All") do |order|
    order.all
  end

  scope("In progress") do |order|
    order.in_progress
  end

   scope("Delivered") do |order|
    order.delivered
  end

   scope("Canceled") do |order|
    order.canceled
  end

  index do
    column :user_id
    column :order_status
    column :number
    column :subtotal
    column :total
    column :section
    column :updated_at
    column :discount_applied
    column :discount_amount
    column :delivery_id
    column :credit_card_id
    actions
  end

  sidebar 'Details', only: :edit do
    attributes_table_for order do
      row :number { |order| h3 order.number }
      row :status { |order| h3 order.order_status.split('_').map(&:capitalize).join(' ') }
      row :total { |order| h3 order.total }
      row :discount { |order| order.discount_applied }
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs { f.input :order_status }
    f.actions
  end

  controller do
    def update
      Order.find(params[:id]).update(order_status: params[:order][:order_status])
      flash[:noties] = 'The Order has been successfully updated'
      redirect_to admin_order_path
    end
  end
end

