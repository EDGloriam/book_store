class ProfilesController < ApplicationController
  before_action :get_current_user
  def show
  end

  def update
    address_type = params[:profile][:type]
    if @user.send(address_type).nil?
      @user.send("create_#{address_type}".to_sym, permitted_params)
    else
      @user.send(address_type.to_sym).update_attributes(permitted_params)
    end
  end

  private

    def get_current_user
      @user = current_user
    end

    def permitted_params
      params.require(:profile).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
    end
end
    # flash[:error] = "You must be logged in to access this section"