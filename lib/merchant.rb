require 'date_validation'
class Merchant
  include DateValidation
  attr_accessor :items, :invoices, :customers
  attr_reader :id, :name, :created_at, :updated_at
  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
    @created_at = time_object(merchant_data[:created_at])
    @updated_at = time_object(merchant_data[:updated_at])
  end

  def inspect
    "#<#{self.class}, ##{id}, name: #{name}>"
  end
end
