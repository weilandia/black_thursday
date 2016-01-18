require 'unit_price'
require 'date_validation'
require 'validate_input'
class Item
  include UnitPrice
  include DateValidation
  include ValidateInput
  attr_accessor :merchant
  attr_reader :id, :name, :description, :unit_price, :unit_price_to_dollars, :merchant_id, :created_at,
  :updated_at
  def initialize(item_data)
    @id = validate_integer(item_data[:id])
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = unit_price_bigdecimal(item_data[:unit_price])
    @unit_price_to_dollars = unit_price_in_dollars
    @merchant_id = validate_integer(item_data[:merchant_id])
    @created_at = time_object(item_data[:created_at])
    @updated_at = time_object(item_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}, price: #{unit_price.to_f}>"
  end
end
