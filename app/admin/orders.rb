ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :id, :user_id, :order_status, :number, :subtotal, :total, :discount_applied, :discount_amount, :delivery_id, :credit_card_id, :updated_at
permit_params :id

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

  filter :order_status
  filter :current_sign_in_at
  filter :total


  form do |f|
    f.inputs do
      f.input :user_id do |product|
        debugger
      end
      f.input :order_status
      f.input :number
      f.input :subtotal
      f.input :total
      f.input :updated_at
      f.input :discount_applied
      f.input :discount_amount
      f.input :delivery_id
      f.input :credit_card_id
    end
  f.actions
  end
end

