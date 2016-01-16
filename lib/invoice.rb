class Invoice
  attr_accessor :merchant, :items
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(invoice_data)
    @id = invoice_data[:id]
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = invoice_data[:created_at]
    @updated_at = invoice_data[:updated_at]
  end
  def inspect
    "#<#{self.class} ##{id} #{status}>"
  end
end
