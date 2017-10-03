module BooksHelper
  def category_size(section = '')
    return Book.all.size if section.nil?
    Book.where("section = '#{section}'").size
  end

  def reviews_count(reviews)
    return "Write the first review" if reviews.count.zero?
    "Reviews (#{reviews.count})"
  end

  def reviewer_name(review)
    profile = review.user.billing_address
    return "#{profile[:first_name]}, #{profile[:last_name]}" if profile
    "#{review.user.email.split('@')[0]}"
  end
end
