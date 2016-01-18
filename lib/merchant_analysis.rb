module MerchantAnalysis
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

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    high_items_merchants = []
     @engine.merchants.all.each do |merchant|
       if merchant.items.count >=  avg + sd
         high_items_merchants << merchant
       end
     end
     high_items_merchants
  end

  def average_average_price_per_merchant
    merchant_count = total_merchant_count
    merchants = @engine.merchants.all
    average_item_prices = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (average_item_prices.inject(:+) / merchant_count).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    item_prices = []
    merchant.items.each { |i| item_prices << i.unit_price }
    return 0.0 if item_prices.empty?
    average = (item_prices.compact.inject(:+) / merchant.items.count) / 100
    average.round(2)
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
end
