require 'mathn'
require_relative '../lib/sales_engine'

class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def total_item_count
    @engine.items.all.count
  end

  def total_merchant_count
    @engine.merchants.all.count
  end

  def item_count_per_merchant
   items_per_merchant = []
   @engine.merchants.all.each do |merchant|
     items_per_merchant << merchant.items.count
   end
   items_per_merchant
  end

  def average_items_per_merchant
    mean(item_count_per_merchant)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_count_per_merchant)
  end

  def total(array)
   array.inject(0){|accum, i| accum + i }
  end

  def mean(array)
   total = total(array)
   total/array.length.to_f
  end

  def sample_variance(mean, array)
   m = mean
   sum = array.inject(0){|accum, i| accum + (i-m)**2 }
   sum/(array.length).to_f
  end

  def standard_deviation(array)
    mean = mean(array)
    variance = sample_variance(mean, array)
    Math.sqrt(variance).round(2)
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

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    item_prices = []
    merchant.items.each do |item|
      item_prices << item.unit_price.to_f
    end
    average_price = item_prices.inject(:+) / merchant.items.count
    average_price
  end

  def all_prices_array
    all_prices = []
    @engine.merchants.all.each do |merchant|
      merchant.items.each do |item|
        all_prices << [item.unit_price.to_f,item]
      end
    end
    all_prices
  end

  def average_price_per_merchant
    all_prices_with_object = all_prices_array.flatten
    all_prices = all_prices_with_object.map do |e|
      if e.class == Float then e end
    end.compact
    average_price = all_prices.inject(:+) / all_prices.count
    average_price
  end

  def golden_items
    all_prices_with_object = all_prices_array.flatten
    all_prices = all_prices_with_object.map do |e|
      if e.class == Float then e end
    end.compact
    sd = standard_deviation(all_prices)
    gold_items = all_prices_with_object.map do |e|
      if e.class == Item
        if  e.unit_price.to_f >= sd * 2
          e.name
        end
      end
    end.compact
    gold_items
  end
end
