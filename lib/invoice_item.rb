require 'make_bigdecimal'
class InvoiceItem
  include MakeBigDecimal
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
  :created_at,:updated_at
  def initialize(invoice_item_data)
    @id = invoice_item_data[:id]
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
    @unit_price = make_bigdecimal(invoice_item_data[:unit_price])
    @created_at = invoice_item_data[:created_at]
    @updated_at = invoice_item_data[:updated_at]
  end

  def inspect
    "#<#{self.class}, ##{id}, invoice_id: #{invoice_id}, quant: #{quantity}>"
  end
end




# Invoice item
  # id, invoice_id, item_id, quantity,
  #  price(record price paid on invoice vs. item price --i.e. discounts etc.)
