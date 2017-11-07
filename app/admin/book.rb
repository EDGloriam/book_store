ActiveAdmin.register Book do

 permit_params :id, :name, :photo, :description, :price, :active, :publicated, :materials,
  :height,:weight, :depth, :category_id, author_ids: []


  index do
    column :id
    column :name
    column :photo do |book|
      image_tag book.photo, size: '45x60'
    end
    column :description
    column :price
    column :active
    column :category do |book|
      category = book.category
      category.name if category
    end
    column :publicated
    column :materials
    column :authors do |book|
      book.authors.map {|author| author.name}.join(', ')
    end
    actions
  end

  show do
    table_for book, id: "book-show-table" do
      column :id
      column :description
      column :price
      column :active
      column :category do |book|
        book.category.name
      end
      column :publicated
      column :materials
    end
  end

  sidebar "Details", only: :show do
    attributes_table_for book do
      row :image do |book|
        image_tag book.photo, size: '170x250'
      end
      row :authors do |book|
        book.authors.map {|author| author.name}.join(', ')
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :photo
      f.input :description
      f.input :price
      f.input :category, as: :select, collection: Category.all.map{ |category| [category.name, category.id]}
      f.input :active
      f.input :publicated
      f.input :materials
      f.input :height
      f.input :weight
      f.input :depth
    end
    f.inputs do
      f.input :authors, as: :select, collection: Author.all.map{ |author| [author.name, author.id]}
    end
    f.actions
  end

  controller do
    def update
      book = Book.find(params[:id])
      book.update(permitted_params[:book])
      redirect_to admin_book_path
    end
  end

end
