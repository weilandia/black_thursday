require 'date_validation'
class Customer
  include DateValidation
  attr_accessor :merchants
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(customer_data)
    @id = customer_data[:id].to_i
    @first_name = customer_data[:first_name]
    @last_name = customer_data[:last_name]
    @created_at = time_object(customer_data[:created_at])
    @updated_at = time_object(customer_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, #{first_name} #{last_name}>"
  end
end
