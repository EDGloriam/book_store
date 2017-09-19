class Book < ApplicationRecord
  # mount_uploader :photo, ImageUploader
  has_one :dimension
  has_and_belongs_to_many :authors, optional: true
  has_many :reviews
  has_many :order_items

  before_destroy :ensure_not_belongs_to_any_order_items

  FILTERS_LIST =  [nil, 'Mobile Development', 'Photo', 'Web Design']

  default_scope { where(active: true) }
  scope :section, -> (section) { where section: section }

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
