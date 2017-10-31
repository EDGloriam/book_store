ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

# "order"=>{"order_status"=>"canceled", "number"=>"R100220001", "subtotal"=>"52.0", "total"=>"67.0",
# "discount_applied"=>"0", "discount_amount"=>"0.0", "delivery_id"=>"1", "credit_card_id"=>"1"}, "commit"=>"Update Order", "id"=>"1"}

permit_params order: [:order_status, :number, :subtotal, :total, :discount_applied, :discount_amount, :delivery_id, :credit_card_id, :updated_at, :id]
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

  # filter :order_status
  # filter :current_sign_in_at
  # filter :total

  # controller do
  #   def update
  #     debugger
  #   end
  # end

  form do |f|
    f.inputs do
      # f.input :user_id do |product|
      #   debugger
      # end
      f.input :order_status
      f.input :number
      f.input :subtotal
      f.input :total
      f.input :discount_applied
      f.input :discount_amount
      # f.input :delivery_id
      # f.input :credit_card_id
    end
  f.actions
  end
end

