class AddressForm
  include ActiveModel::Model
  include Virtus.model

  attribute :params, Hash
  attribute :user, User

  attribute :first_name, String, :default => ''
  attribute :last_name, String, :default => ''
  attribute :address, String, :default => ''
  attribute :city, String, :default => ''
  attribute :zip, Integer, :default => 0
  attribute :country, String, :default => ''
  attribute :phone, Integer, :default => 0

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, format: { with: /\A[A-Za-z]{0,49}\z/ }
  validates :city, :country, format: { with: /\A[A-Za-z\s]{0,49}\z/ }
  validates :address, format: { with: /\A[-A-Za-z\s\d,]{0,49}\z/ }
  validates :zip, format: { with: /\A[0-9]{0,5}\z/ }
  validates :phone, format: { with: /\A[+]?\d+\z/ }
  validates :phone, length: { is: 12 }

  def initialize(params, type)
    @params = params.has_key?(:address) ? params[:address][type] : attributes
    @user = params[:user]
    debugger
    attributes = @user.send("#{type}_address") || @user.send("build_#{type}_address".to_sym, @params)
    debugger
  end

  def save
    address_object = @user.send("#{current}_address") || @user.send("build_#{current}_address")
    self.assign_attributes(@params)
    address_object.save! if valid?
  end
end
