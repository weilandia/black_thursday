require 'date_validation'
require 'validate_input'
class Transaction
  include DateValidation
  include ValidateInput
  attr_accessor :invoice
  attr_reader  :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date, :result, :created_at, :updated_at
  def initialize(transaction_data)
    @id = validate_integer(transaction_data[:id])
    @invoice_id = validate_integer(transaction_data[:invoice_id])
    @credit_card_number = validate_integer(transaction_data[:credit_card_number])
    @credit_card_expiration_date =
    transaction_data[:credit_card_expiration_date]
    @result = transaction_data[:result]
    @created_at = time_object(transaction_data[:created_at])
    @updated_at = time_object(transaction_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, #{result}>"
  end
end
