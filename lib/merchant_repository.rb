require_relative 'merchant'
require_relative 'data_parser'

class MerchantRepository
  include DataParser
  attr_reader :all_merchants

  def initialize
    @all_merchants = []
  end

  def inspect
    "#<#{self.class} #{@all_merchants.size} rows>"
  end

  def create_instance(merchant_data)
    merchant = Merchant.new(merchant_data)
    @all_merchants << merchant
  end

  def all
    all_merchants
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(merchant_id)
    search_result = @all_merchants.select {|search| search.id == merchant_id}[0]
    exact_search(search_result)
  end

  def find_by_name(mer_name)
    result = @all_merchants.select {|s| s.name.downcase == mer_name.downcase}[0]
    exact_search(result)
  end

  def find_all_by_name(search_frag)
    @all_merchants.select {|s| s.name.downcase.include? search_frag.downcase}
  end
end
