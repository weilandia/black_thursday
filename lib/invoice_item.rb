require 'validate_input'
class InvoiceItem
  include ValidateInput
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :unit_price_to_dollars,
              :created_at,
              :updated_at

  def initialize(invoice_item_data)
    @id = validate_integer(invoice_item_data[:id])
    @item_id = validate_integer(invoice_item_data[:item_id])
    @invoice_id = validate_integer(invoice_item_data[:invoice_id])
    @quantity = validate_integer(invoice_item_data[:quantity])
    @unit_price = unit_price_bigdecimal(invoice_item_data[:unit_price])
    @unit_price_to_dollars = unit_price_in_dollars
    @created_at = time_object(invoice_item_data[:created_at])
    @updated_at = time_object(invoice_item_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, invoice_id: #{invoice_id}, quant: #{quantity}>"
  end
end




# Invoice item
  # id, invoice_id, item_id, quantity,
  #  price(record price paid on invoice vs. item price --i.e. discounts etc.)
