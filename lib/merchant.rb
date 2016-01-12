class Merchant

  attr_reader :id, :name, :created_at, :updated_at 
  def initialize(merchant_data)
    @id = merchant_data[:id]
    @name = merchant_data[:name]
    @created_at =  merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
  end
end


# Invoices => id, merchantid (references id of merchant), customerid,
