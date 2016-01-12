class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :items
  def initialize(merchant_data, item_repo)
    @id = merchant_data[:id]
    @name = merchant_data[:name]
    @created_at =  merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
    @items = item_repo.find_by_merchant_id(@id)
  end
end


# Invoices => id, merchantid (references id of merchant), customerid,
