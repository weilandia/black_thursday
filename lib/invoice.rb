require 'date_validation'
require 'validate_input'
class Invoice
  include DateValidation
  include ValidateInput
  attr_accessor :merchant, :items, :transactions, :customer
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(invoice_data)
    @id = validate_integer(invoice_data[:id])
    @customer_id = validate_integer(invoice_data[:customer_id])
    @merchant_id = validate_integer(invoice_data[:merchant_id])
    @status = validate_symbol(invoice_data[:status].to_sym)
    @created_at = time_object(invoice_data[:created_at])
    @updated_at = time_object(invoice_data[:updated_at])
  end
  def inspect
    "#<#{self.class} ##{id} #{status}>"
  end
end
