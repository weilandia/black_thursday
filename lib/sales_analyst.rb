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
    mean(item_count_per_merchant).round(2)
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
   sum/(array.length-1).to_f
  end

  def standard_deviation(array)
    mean = mean(array)
    variance = sample_variance(mean, array)
    Math.sqrt(variance).round(2)
  end

  def merchants_with_low_item_count
    sd = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    low_items_merchants = []
     @engine.merchants.all.each do |merchant|
       if merchant.items.count <=  avg - sd
         low_items_merchants << merchant
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
    BigDecimal.new("#{average_price.round(2)}")
  end

  def all_prices_array
    all_prices = []
    @engine.merchants.all.each do |merchant|
      merchant.items.each { |item| all_prices << item }
    end
    all_prices
  end

  def average_price_per_merchant
    all_prices = all_prices_array.map { |item| item.unit_price.to_f }
    average_price = all_prices.inject(:+) / all_prices.count
    BigDecimal.new("#{average_price.round(2)}")
  end

  def golden_items
    all_prices = all_prices_array.map { |item| item.unit_price.to_f }
    sd = standard_deviation(all_prices)
    gold_items = all_prices_array.map do |item|
      if item.unit_price.to_f >= sd * 2
          item
      end
    end.compact
    gold_items
  end

#Invoices
  def total_invoice_count
    @engine.invoices.all.count
  end

  def average_invoices_per_merchant
    (total_invoice_count.to_f / total_merchant_count).round(2)
  end

  def invoice_count_per_merchant
   invoices_per_merchant = []
   @engine.merchants.all.each do |merchant|
     invoices_per_merchant << merchant.invoices.count
   end
   invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_count_per_merchant)
  end


  def top_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    high_invoices_merchants = []
     @engine.merchants.all.each do |merchant|
       if merchant.invoices.count >=  avg + (2 * sd)
         high_invoices_merchants << merchant
       end
     end
     high_invoices_merchants
  end

  def bottom_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    low_invoices_merchants = []
     @engine.merchants.all.each do |merchant|
       if merchant.invoices.count <=  avg - (2 * sd)
         low_invoices_merchants << merchant
       end
     end
     low_invoices_merchants
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(invoice_count_per_day.values)
  end

  def top_days_by_invoice_count
    sd = average_invoices_per_day_standard_deviation
    avg = average_invoices_per_day
     invoice_count_per_day.select do |day, count|
       count > avg + sd
    end.keys
  end

  def average_invoices_per_day
    mean(invoice_count_per_day.values).round(2)
  end

  def invoice_count_hash_by_day
    all_invoice_days = []
    @engine.invoices.all.each do |invoice|
      all_invoice_days << invoice.created_at.strftime("%A")
    end
    all_invoice_days.group_by { |day| day }
  end

  def invoice_count_per_day
    hash = invoice_count_hash_by_day
    hash.map do |k, v|
      [k, v.count]
    end.to_h
  end

  def total_invoice_count
    @engine.invoices.all.count
  end

  def invoice_status(status)
    return 0.0 if invoice_count_by_status(status) == 0
    (total_invoice_count.to_f / invoice_count_by_status(status)).round(2)
  end


  def invoice_count_by_status(status)
    @engine.invoices.all.select do |invoice|
      if invoice.status == status
        invoice
      end
    end.length
  end

end
