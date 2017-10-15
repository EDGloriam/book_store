class CallbacksController < Devise::OmniauthCallbacksController
  # before_action :set_order
  def facebook
    puts "=============CALBACK========="
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # @order.update_attributes(user_id: @user.id)
    sign_in_and_redirect @user
  end
end