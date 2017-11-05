class Book < ApplicationRecord
  mount_uploader :photo, ImageUploader

  has_many :author_books, dependent: :nullify
  has_many :authors, through: :author_books

  has_many :reviews
  has_many :order_items
  belongs_to :category
  before_destroy :ensure_not_belongs_to_any_order_items

  default_scope { where(active: true) }
  scope :category, -> (category) do
    # debugger
    if category.nil?
      where(active: true)
    else
      where category_id: category
    end
  end

  scope :filter, -> (parametr) do
    return where(nil) if parametr.nil?
    case parametr
      when 'price_low_first'
        order(:price)
      when 'price_hight_first'
        order(:price).reverse_order
      when 'newest_first'
        order(:created_at).reverse_order
      when 'popular_first'

      end
  end

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
