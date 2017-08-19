module ProfilesHelper
  def find_attribute_in(attr, address_type)
    return @user.send(address_type.to_sym)[attr] unless @user.send(address_type.to_sym).nil?
    default_placeholder(attr)
  end

  def default_placeholder(attr)
    return attr.to_s.split("_").map(&:capitalize).join(' ') unless attr == 'phone'
    'Example +355 66 123 4567'
  end

end
