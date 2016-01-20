module TransactionRelationships
  def transaction_relationships
    transaction_invoice_relationship
  end

  def transaction_invoice_relationship
    transactions.all.each do |transaction|
      transaction.invoice = invoices.find_by_id(transaction.invoice_id)
    end
  end
end
