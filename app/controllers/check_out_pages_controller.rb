class CheckOutPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    render_wizard
  end
end
