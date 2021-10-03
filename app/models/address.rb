class Address < ApplicationRecord
  belongs_to :end_user
  
  def address_property
    self.postal_code + self.address + self.name
  end
end
