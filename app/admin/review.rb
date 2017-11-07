ActiveAdmin.register Review do
  permit_params :user_id, :book_id, :text, :verified, :rate_stars
end
