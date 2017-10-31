ActiveAdmin.register Book do

 permit_params :id, :name, :photo, :description, :price, :active, :section, :publicated, :materials,
  :height,:weight, :depth, authors_attributes: ['0' => 'name']

  index do
    column :id
    column :name
    column :photo do |book|
      # debugger
      # "#{book.photo.to_s[0, 19]}...#{book.photo.to_s[60, 20]}"
      image_tag book.photo, size: '45x60'
    end
    column :description
    column :price
    column :active
    column :section
    column :publicated
    column :materials
    column :author do |book|
      book.authors
    end
    actions
  end

  # show do |book|
  #   id_column
  #   column :name do
  #     book.name
  #   end
  #   # column :photo
  #   # column :description
  #   # column :price
  #   # column :active
  #   # column :section
  #   # column :materials
  #   # column :author
  # end
  # controller do
  # def update
  # debugger
  # end
  # end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :photo
      f.input :description
      f.input :price
      f.input :section
      f.input :active
      f.input :publicated
      f.input :materials
      f.input :height
      f.input :weight
      f.input :depth
      f.has_many :authors, heading: 'Author',
                           new_record: "Create Author" do |a|
        a.input :name
      end
    end
    f.actions
  end


end
# {"name"=>"Green Brains", "description"=>"...", "price"=>"54.0",
#   "section"=>"Mobile Development", "active"=>"1",
#    "publication(1i)"=>"",
#     "publication(2i)"=>"",
#      "publication(3i)"=>"",
#  "materials"=>"Hardcove, glossy paper",
#  "height"=>"0.6",
#  "weight"=>"0.9",
#  "depth"=>"0.2",
#  "authors_attributes"=>{"0"=>{"name"=>"aaaaaaaaaaaaaaaaaaaaaaaa", "id"=>"35"}}},
#  "id"=>"200"}