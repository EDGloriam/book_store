class Coupon < ApplicationRecord
  validates :code, uniqueness: true
  before_validation :set_code

  def try_to_use
    return 0 unless self.used
    self.update(used: false)
    self.amount
  end

  private
    def set_code
      self.update(code: generate_code)
    end

    def find_coupon
      Coupon.find_by(code: code)
    end

    def generate_code
      loop do
        code = (0..8).map { (65 + rand(26)).chr }.join
        break unless Coupon.find_by(code: code)
      end
      code
    end

end
