require 'validate_input'
class Transaction
  include ValidateInput
  attr_accessor :invoice
  attr_reader   :id,
                :result,
                :invoice_id,
                :created_at,
                :updated_at,
                :credit_card_number,
                :credit_card_expiration_date

  def initialize(tx_data)
    @id = validate_int(tx_data[:id])
    @invoice_id = validate_int(tx_data[:invoice_id])
    @credit_card_number = validate_int(tx_data[:credit_card_number])
    @credit_card_expiration_date =
    tx_data[:credit_card_expiration_date]
    @result = tx_data[:result]
    @created_at = time_object(tx_data[:created_at])
    @updated_at = time_object(tx_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, #{result}>"
  end
end
