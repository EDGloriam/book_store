ActiveAdmin.register Author do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name

index do
    id_column
    column :name
    column :books do |object|
      # debugger
      object.books.map {|book| book.name}.join(", ")

    end
    actions
  end
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
