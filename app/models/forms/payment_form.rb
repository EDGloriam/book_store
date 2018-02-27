class PaymentForm
  attr_accessor :credit_card
  attr_reader :user

  def initialize(user, params = nil)
    @complete = false
    @user = user
    @credit_card = user.orders.in_progress[0].credit_card || CreditCard.new(params)
  end

  def save
    if @credit_card.save
      @user.orders.in_progress[0].update_attribute(:credit_card_id, @credit_card.id)
      @user.update_attribute(:complete_step, 'payment')
      @complete = true
      true
    else
      false
    end
  end
end
