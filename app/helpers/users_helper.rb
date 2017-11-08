# Needs this because I use Devise form outside from Devise controller
# https://stackoverflow.com/a/6393151/8226738
module UsersHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
