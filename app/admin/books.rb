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



 permit_params :name,:photo, :description, :price,
  :active, :section, :publication, :materials

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
