class Invoice
  attr_accessor :merchant, :items
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(invoice_data)
    @id = invoice_data[:id]
    @customer_id = invoice_data[:customer_id]
    @merchant_id = invoice_data[:merchant_id]
    @status = invoice_data[:status]
    @created_at = invoice_data[:created_at]
    @updated_at = invoice_data[:updated_at]
  end
  def inspect
    "#<#{self.class} ##{id})>"
  end
end


# Invoice
  # id, merchan_id, customer_id
