module CustomerRelationships
  def customer_relationships
    customer_merchant_relationship
  end

  def customer_merchant_relationship
    customers.all.each do |customer|
      invs = invoices.find_all_by_customer_id(customer.id)
      merch_ids = invs.map(&:merchant_id).uniq
      customer.merchants = merch_ids.map { |id| merchants.find_by_id(id) }
    end
  end
end
