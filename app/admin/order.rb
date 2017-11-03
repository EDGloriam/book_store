ActiveAdmin.register Order do

permit_params order: [:order_status]
# permit_params :id

index do
    column :id
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

  sidebar "Details", only: :edit do
    attributes_table_for order do
      row :number do |order|
        h3 order.number
      end
      row :status do |order|
        h3 order.order_status.split('_').map(&:capitalize).join(' ')
      end
      row :total do |order|
        h3 order.total
      end
      row :discount do |order|
        order.discount_applied
      end
    end
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys#To display a list of all validation errors
    f.inputs do
      f.input :order_status
    end
  f.actions
  end


  controller do
    def update
      Order.find(params[:id]).update(order_status: params[:order][:order_status])
      flash[:noties] = "The Order has been successfully updated"
      redirect_to admin_order_path
    end
  end
end

