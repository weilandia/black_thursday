require 'validate_input'
class Merchant
  include ValidateInput
  attr_accessor :items,
                :revenue,
                :invoices,
                :customers
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchant_data)
    @id = validate_integer(merchant_data[:id])
    @name = merchant_data[:name]
    @created_at = time_object(merchant_data[:created_at])
    @updated_at = time_object(merchant_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}>"
  end
end
