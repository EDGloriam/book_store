module ApplicationHelper
   def prepare_for_view(authors)
    return authors[0].name if authors.size == 1
    return authors.map { |author| "#{author.name}" }.join(', ') if authors.size > 1
    'error from books_helper.rb'
  end
end
