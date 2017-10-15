ActiveAdmin.register Book do
  index do
    column :id
    column :name
    column :photo do |book|
      "#{book.photo.to_s[0, 19]}...#{book.photo.to_s[60, 20]}"
    end
    column :description
    column :price
    column :active
    column :section
    column :updated_at
    column :publication
    column :materials
  end


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name,:photo, :description, :price,
  :active, :section, :publication, :publication, :publication, :materials

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
