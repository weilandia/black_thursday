require 'make_bigdecimal'
class Item
  include MakeBigDecimal
  attr_accessor :merchant
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
  :updated_at
  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = make_bigdecimal(item_data[:unit_price])
    @merchant_id = item_data[:merchant_id].to_i
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}, price: #{unit_price.to_f}>"
  end
end
