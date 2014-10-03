module ApplicationHelper

  def get_current_address_types
    address_types = [AddressType.all]
    return address_types.flatten
  end
end
