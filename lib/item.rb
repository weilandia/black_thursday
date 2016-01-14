class Item
  attr_accessor  :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :merchant
  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
    @merchant_id = item_data[:merchant_id]
    @created_at = Time.parse(item_data[:created_at])
    @updated_at = Time.parse(item_data[:updated_at])
  end
end
