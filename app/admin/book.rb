ActiveAdmin.register Book do

 permit_params :id, :name, :photo, :description, :price, :active, :section, :publicated, :materials,
  :height,:weight, :depth, authors_attributes: ['0' => 'name']

  index do
    column :id
    column :name
    column :photo do |book|
      image_tag book.photo, size: '45x60'
    end
    column :description
    column :price
    column :active
    column :section
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
      column :section
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
    f.semantic_errors *f.object.errors.keys #To display a list of all validation errors
    f.inputs do
      f.input :name
      f.input :photo
      f.input :description
      f.input :price
      f.input :section, as: :select, collection: book.authors
      f.input :active
      f.input :publicated
      f.input :materials
      f.input :height
      f.input :weight
      f.input :depth
      f.input :authors, as: :select, collection: book.authors
    end
    f.actions
  end


end
