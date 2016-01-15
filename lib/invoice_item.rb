require 'bigdecimal'

class InvoiceItem
  attr_accessor  :id, :item_id,  :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  def initialize(invoice_item_data)
    @id = invoice_item_data[:id]
    @item_id = invoice_item_data[:item_id]
    @invoice_id = invoice_item_data[:invoice_id]
    @quantity = invoice_item_data[:quantity]
    @unit_price = BigDecimal.new(invoice_item_data[:unit_price].to_f, invoice_item_data[:unit_price].to_s.length)
    @created_at = invoice_item_data[:created_at]
    @updated_at = invoice_item_data[:updated_at]
  end

end




# Invoice item
  # id, invoice_id, item_id, quantity, price(record price paid on invoice vs. item price --i.e. discounts etc.)
