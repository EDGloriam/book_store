class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, :book_id, :text, :rate_stars, presence: true
  validates :rate_stars,
    numericality: { only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5}
  validates :text, format: { with: /\A[a-zA-Z\d\s]+[-!#$%&'*+\/=?^_`{|}~.,]?[a-zA-Z\d\s]*\z/ }

  scope :newest, -> { where verified: false }
  scope :processed, -> { where verified: true }
end
