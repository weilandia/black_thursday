module InvoiceRelationships
  def invoice_relationships
    invoice_merchant_relationship
    invoice_item_relationship
    invoice_transaction_relationship
    invoice_customer_relationship
    invoice_invoice_item_relationship
  end

  def invoice_merchant_relationship
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
    end
  end

  def invoice_customer_relationship
    invoices.all.each do |invoice|
      invoice.customer = customers.find_by_id(invoice.customer_id)
    end
  end

  def invoice_item_relationship
    item_ids = []
    invoices.all.each do |invoice|
      inv_items = invoice_items.find_all_by_invoice_id(invoice.id)
    item_ids = inv_items.map { |inv_item| inv_item.item_id}
    invoice.items = item_ids.map { |item_id| items.find_by_id(item_id) }
    end
  end

  def invoice_invoice_item_relationship
    invoices.all.each do |invoice|
      invoice.invoice_items = invoice_items.find_all_by_invoice_id(invoice.id)
    end
  end

  def invoice_transaction_relationship
    invoices.all.each do |invoice|
      invoice.transactions = transactions.find_all_by_invoice_id(invoice.id)
    end
  end
end
