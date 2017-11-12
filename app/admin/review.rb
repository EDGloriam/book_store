ActiveAdmin.register Review do
  permit_params :user_id, :book_id, :text, :verified, :rate_stars

  scope("All") do |review|
    review.all
  end

  scope("New") do |review|
    review.newest
  end

  scope("Processed") do |review|
    review.processed
  end

  index do
    column :user_id
    column :book do |review|
      review.book.name
    end
    column :text
    column :verified
    column :rate_stars
  end
end
