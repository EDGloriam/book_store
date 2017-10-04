module ProfilesHelper
  def find_attribute_in(attr, address_type)
    return address_type[attr] if address_type[attr].present?
    default_placeholder(attr)
  end

  def default_placeholder(attr)
    return attr.to_s.split("_").map(&:capitalize).join(' ') unless attr == :phone
    'Example +355 66 123 4567'
  end

  def error_msg(attr, model)
    return model.errors.messages[attr].first unless model.errors.messages[attr].empty?
    ''
  end
end
