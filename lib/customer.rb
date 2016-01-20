require 'validate_input'
class Customer
  include ValidateInput
  attr_accessor :merchants
  attr_reader   :id,
                :last_name,
                :first_name,
                :created_at,
                :updated_at

  def initialize(customer_data)
    @id = validate_integer(customer_data[:id])
    @first_name = customer_data[:first_name]
    @last_name = customer_data[:last_name]
    @created_at = time_object(customer_data[:created_at])
    @updated_at = time_object(customer_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, #{first_name} #{last_name}>"
  end
end
