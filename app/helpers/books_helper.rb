module BooksHelper
  def category_size(section = '')
    return Book.all.size if section.nil?
    Book.where("section = '#{section}'").size
  end

  def reviews_count(reviews)
    return "Write the first review" if reviews.count.zero?
    "Reviews (#{reviews.count})"
  end

end
