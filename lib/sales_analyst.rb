$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'mathn'
require 'sales_engine'

class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def item_count_per_merchant
   items_per_merchant = []
   @engine.merchants.all.each do |merchant|
     items_per_merchant << merchant.items.count
   end
   items_per_merchant
  end

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
    mean = average_items_per_merchant
    count_minus_mean_squared = item_count_per_merchant.map do |merchant|
      (merchant - mean) ** 2
    end

    new_total = count_minus_mean_squared.inject(:+)

    new_average = new_total / total_item_count

    standard_deviation = Math.sqrt(new_average)

    standard_deviation.round(2)
  end

  def merchants_with_low_item_count
    sd = average_items_per_merchant_standard_deviation
    low_items_merchants = []
     @engine.merchants.all.each do |merchant|
       if merchant.items.count < sd
         low_items_merchants << merchant.name
       end
     end
     low_items_merchants
  end
end
