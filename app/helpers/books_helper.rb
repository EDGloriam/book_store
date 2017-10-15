module BooksHelper
  def category_size(section = '')
    return Book.all.size if section.nil?
    Book.where("section = '#{section}'").size
  end

  def reviews_count(reviews)
    return "Write the first review" if reviews.count.zero?
    "Reviews (#{reviews.count})"
  end

  def show_stars(number)
    content_tag(:div, class: 'mb-15') do
     1.upto(number) do
        concat content_tag(:i, '',class: %w(fa fa-star rate-star))
      end
    end
  end

  def reviewer_name(review)
    profile = review.user.billing_address
    return "#{profile[:first_name]}, #{profile[:last_name]}" if profile
    "#{review.user.email.split('@')[0]}"
  end

  def user_logo(user)
    user.email[0].capitalize
  end
end
