require 'unit_price'
class Item
  include UnitPrice
  attr_accessor :merchant
  attr_reader :id, :name, :description, :unit_price, :unit_price_to_dollars, :merchant_id, :created_at,
  :updated_at
  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = unit_price_bigdecimal(item_data[:unit_price])
    @unit_price_to_dollars = unit_price_in_dollars
    @merchant_id = item_data[:merchant_id].to_i
    @created_at = Time.parse(item_data[:created_at])
    @updated_at = Time.parse(item_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}, price: #{unit_price.to_f}>"
  end
end
