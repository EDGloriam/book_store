class PaymentForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :credit_card

  def initialize(user, params = nil)
    @credit_card = user.orders.in_progress[0].credit_card || CreditCard.create(params)
    @credit_card.assign_attributes(params || {})
    @user = user
  end

  def save
    if @credit_card.save
      @user.orders.in_progress[0].update_attribute(:credit_card_id, @credit_card.id)
      true
    else
      false
    end
  end



end