class Book < ApplicationRecord
  mount_uploader :photo, ImageUploader

  has_many :author_books, dependent: :nullify
  has_many :authors, through: :author_books

  has_many :reviews
  has_many :order_items
  belongs_to :category
  before_destroy :ensure_not_belongs_to_any_order_items

  validates :name, :price, :description,
            :publicated, :height, :weight, :depth,
            :materials, :category_id, presence: true
  validates :name, uniqueness: true
  validates_length_of :name, maximum: 100
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates_length_of :materials, maximum: 50
  validates :height, :weight, :depth, numericality: { only_float: true }
  validates_length_of :description, in: 5..2000

  default_scope { where(active: true) }
  scope :category, -> (category) { category.nil? ? all : where(category_id: category) }
  scope :filter, -> (parametr) do
    case parametr
    when 'price:_Low_first'
      order(:price)
    when 'price:_Hight_first'
      order(:price).reverse_order
    when 'newest_first'
      order(:created_at).reverse_order
    when 'popular_first'
    else
      all
    end
  end

  private

    def ensure_not_belongs_to_any_order_items
      if order_items.empty?
        true
      else
        errors.add(:base, 'belongs to existent order_item')
        false
      end
    end

end
