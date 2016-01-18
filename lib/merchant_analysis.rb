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

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    item_prices = []
    merchant.items.each do |item|
      item_prices << item.unit_price.to_f
    end
    average_price = (item_prices.inject(:+) / merchant.items.count) / 100
    average_price.round(2)
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
