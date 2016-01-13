$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'sales_engine'

class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  # def item_count_per_merchant
  #  items_per_merchant = []
  #  @engine.merchants.all.each do |merchant|
  #    items_per_merchant << merchant.items.count
  #  end
  #  items_per_merchant
  # end

  def total_merchant_count
    @engine.merchants.all.count
  end

  def total_item_count
    @engine.items.all.count
  end

  def average_items_per_merchant
    total_item_count.to_f / total_merchant_count
  end

  def average_items_per_merchant_standard_deviation

  end
end
