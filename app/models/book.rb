class Book < ApplicationRecord
  mount_uploader :photo, ImageUploader

  has_many :author_books, dependent: :nullify
  has_many :authors, through: :author_books

  # accepts_nested_attributes_for :authors
  has_many :reviews
  has_many :order_items
  belongs_to :category
  before_destroy :ensure_not_belongs_to_any_order_items

  # FILTERS_LIST =  ['Mobile Development', 'Photo', 'Web Design']

  default_scope { where(active: true) }
  scope :category, -> (category) { where category_id: category }

    private

      def ensure_not_belongs_to_any_order_items
        if order_items.empty?
          return true
        else
          errors.add(:base, 'belongs to existent order_item')
          return false
        end
      end

end
