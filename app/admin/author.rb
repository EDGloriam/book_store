ActiveAdmin.register Author do
  permit_params :name

  index do
    id_column
    column :name
    column :books do |author|
      author.books.map {|book| book.name}.join(', ')
    end
    actions
  end
end
