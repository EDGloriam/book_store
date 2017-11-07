class Coupon < ApplicationRecord
  before_validation :set_code
  validates :code, presence: true
  validates :discount, presence: true
  validates :discount, numericality: { only_float: true, greater_than_or_equal_to: 0.01}

  def applied
    update_attribute(:used, true)
    discount
  end

  private

    def set_code
      coupon_code = generate_code
      unic?(coupon_code) ? self.code = coupon_code : set_code
    end

    def unic?(code)
      return false if Coupon.find_by(code: code)
      true
    end

    def generate_code
      (0..8).map { (65 + rand(26)).chr }.join
    end

end
