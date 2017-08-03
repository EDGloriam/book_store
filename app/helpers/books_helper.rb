module BooksHelper
  def category_size(section = '')
    return Book.all.size if section.empty?
    Book.where("section = '#{section}'").size
  end

  def prepare_for_view(authors)
    return authors[0].name if authors.size == 1
    authors.map { |author| "#{author.name}" }.join(', ')
  end
end
