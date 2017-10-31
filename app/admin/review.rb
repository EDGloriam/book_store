ActiveAdmin.register Review do
 permit_params :user_id, :book_id, :text, :verified, :rate_stars
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
