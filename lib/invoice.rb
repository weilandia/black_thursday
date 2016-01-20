require 'validate_input'
class Invoice
  include ValidateInput
  attr_accessor :items,
                :customer,
                :merchant,
                :transactions,
                :invoice_items
  attr_reader   :id,
                :status,
                :created_at,
                :updated_at,
                :customer_id,
                :merchant_id

  def initialize(invoice_data)
    @id = validate_integer(invoice_data[:id])
    @customer_id = validate_integer(invoice_data[:customer_id])
    @merchant_id = validate_integer(invoice_data[:merchant_id])
    @status = validate_symbol(invoice_data[:status])
    @created_at = time_object(invoice_data[:created_at])
    @updated_at = time_object(invoice_data[:updated_at])
  end
  def inspect
    "#<#{self.class} ##{id} #{status}>"
  end

  def is_paid_in_full?
    transactions.any? { |t| t.result == "success" }
  end

  def total
    total = invoice_items.map { |i| i.unit_price * i.quantity }.inject(:+)
    (total / 100).round(2)
  end
end
