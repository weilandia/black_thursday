class Transaction
  attr_reader  :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at
  def initialize(transaction_data)
    @id = transaction_data[:id]
    @invoice_id = transaction_data[:invoice_id]
    @credit_card_number = transaction_data[:credit_card_number]
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result = transaction_data[:result]
    @created_at = transaction_data[:created_at]
    @updated_at = transaction_data[:updated_at]
  end
  def inspect
    "#<#{self.class} ##{id})>"
  end
end


# Transactions --nobody cares about transactions besides invoices
  # id
  # invoice_id
  # result
