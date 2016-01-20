module MerchantRelationships
  def merchant_relationships
    merchant_item_relationship
    merchant_invoice_relationship
    merchant_customer_relationship
  end

  def merchant_item_relationship
    merchants.all.each do |merchant|
      merchant.items = items.find_all_by_merchant_id(merchant.id)
    end
  end

  def merchant_invoice_relationship
    merchants.all.each do |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)
    end
  end

  def merchant_customer_relationship
    cust_ids = []
    merchants.all.each do |merchant|
      invs = invoices.find_all_by_merchant_id(merchant.id)
      cust_ids = invs.map { |inv| inv.customer_id}.uniq
      merchant.customers = cust_ids.map { |id| customers.find_by_id(id) }
    end
  end

  def merchant_revenue_relationship #dependent relationship
    merchants.all.each do |merchant|
      invs = merchant.invoices.select { |i| i.is_paid_in_full? == true }
      merchant.revenue = invs.map { |i| i.total }.inject(0,:+)
    end
  end
end
