module BooksHelper
  def category_size(section = '')
    return Book.all.size if section.nil?
    Book.where("section = '#{section}'").size
  end

end
