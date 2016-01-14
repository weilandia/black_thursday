class Merchant

  attr_accessor :id, :name, :created_at, :updated_at, :items, :invoices
  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
    @created_at = Time.parse(merchant_data[:created_at])
    @updated_at = Time.parse(merchant_data[:updated_at])
  end
end


# Invoices => id, merchantid (references id of merchant), customerid,
