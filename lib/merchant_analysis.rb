module MerchantAnalysis
  def all_merchants
    engine.merchants.all
  end

  def total_merchant_count
    engine.merchants.all.count
  end

  def item_count_per_merchant
    engine.merchants.all.map { |m| m.items.count }
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
    all_merchants.map { |m| m if m.items.count <= avg - sd }.compact
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    all_merchants.map { |m| m if m.items.count >= avg + sd }.compact
  end

  def average_average_price_per_merchant
    avg_prices = all_merchants.map { |m| average_item_price_for_merchant(m.id) }
    (avg_prices.inject(:+) / total_merchant_count).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    itm_prices = merchant.items.map(&:unit_price).compact
    return 0.0 if itm_prices.empty?
    average = (itm_prices.inject(0, :+) / merchant.items.count)
    (average / 100).round(2)
  end

  def top_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    all_merchants.map { |m| m if m.invoices.count >= avg + (2 * sd) }.compact
  end

  def bottom_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    all_merchants.map { |m| m if m.invoices.count <= avg - (2 * sd) }.compact
  end

  def merchants_with_revenue
    all_merchants.reject { |m| m.revenue.nil? || m.revenue == 0 }
  end

  def merchants_ranked_by_revenue
    merchants_with_revenue.sort_by(&:revenue).reverse
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue[0..(x - 1)]
  end

  def merchants_with_pending_invoices
    merchants = []
    all_merchants.map do |merchant|
      if !merchant.invoices.select { |i| !i.is_paid_in_full? }.empty?
        merchants << merchant
      end
    end
    merchants
  end

  def merchants_with_only_one_item
    engine.merchants.all.select { |m| m.items.count == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |m|
      m.created_at.month == Time.parse(month).month
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    invoices = merchant.invoices.select(&:is_paid_in_full?)
    invoices.map(&:total).inject(:+)
  end

  def most_sold_item_for_merchant(merchant_id)
    merch = engine.merchants.find_by_id(merchant_id)
    invoices = merch.invoices.select { |i| i.is_paid_in_full? }
    inv_itms = invoices.map(&:invoice_items).flatten
    most_sold = inv_itms.sort_by(&:quantity).last
    return nil if most_sold.nil?
    engine.items.find_by_id(most_sold.item_id)
  end

  def best_item_for_merchant(merchant_id)
    merch = engine.merchants.find_by_id(merchant_id)
    invoices = merch.invoices.select(&:is_paid_in_full?)
    inv_itms = invoices.map { |i| i.invoice_items }.flatten
    best_item = inv_itms.sort_by { |i| i.unit_price * i.quantity }.last
    return nil if best_item.nil?
    engine.items.find_by_id(best_item.item_id)
  end
end
