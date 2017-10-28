class PaymentForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :credit_card
  attr_reader :user

  def initialize(user, params = nil)
    @user = user
    @credit_card = user.orders.in_progress[0].credit_card || CreditCard.create(params)
    @credit_card.assign_attributes(params || {})
  end

  def save
    if @credit_card.save
      @user.orders.in_progress[0].update_attribute(:credit_card_id, @credit_card.id)
      @user.update_attribute(:complete_step, 'payment')
      true
    else
      false
    end
  end


end