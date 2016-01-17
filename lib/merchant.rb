class Merchant
  attr_accessor :items, :invoices, :customers
  attr_reader :id, :name, :created_at, :updated_at
  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
    @created_at = Time.parse(merchant_data[:created_at])
    @updated_at = Time.parse(merchant_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}>"
  end
end
