module TransactionRelationships
  def transaction_relationships
    transaction_invoice_relationship
  end

  def transaction_invoice_relationship
    transactions.all.each { |t| t.invoice = invoices.find_by_id(t.invoice_id) }
  end
end
