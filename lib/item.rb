class Item
  attr_reader  :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :merchant
  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price].to_i
    @merchant_id = item_data[:merchant_id]
    @created_at =  Time.new(item_data[:created_at])
    @updated_at = Time.new(item_data[:updated_at])
  end

  def load_merchant(merchant)
    @merchant = merchant
  end
end
