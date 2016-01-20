require 'validate_input'
class Item
  include ValidateInput
  attr_accessor :merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at,
                :unit_price,
                :description,
                :merchant_id,
                :unit_price_to_dollars

  def initialize(item_data)
    @id = validate_int(item_data[:id])
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = unit_price_bigdec(item_data[:unit_price])
    @unit_price_to_dollars = unit_price_in_dollars
    @merchant_id = validate_int(item_data[:merchant_id])
    @created_at = time_object(item_data[:created_at])
    @updated_at = time_object(item_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}, price: #{unit_price.to_f}>"
  end
end
