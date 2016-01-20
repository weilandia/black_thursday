require_relative 'merchant'
require_relative 'data_parser'
require_relative 'instantiate_repos'

class MerchantRepository
  include DataParser
  include InstantiateRepos
  attr_reader :all_merchants, :all

  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{all_merchants.size} rows>"
  end

  def create_instance(merchant_data)
    merchant = Merchant.new(merchant_data)
    @all << merchant
  end

  def all_merchants
    @all
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(merchant_id)
    search_result = all_merchants.select {|search| search.id == merchant_id}[0]
    exact_search(search_result)
  end

  def find_by_name(mer_name)
    result = all_merchants.select {|s| s.name.downcase == mer_name.downcase}[0]
    exact_search(result)
  end

  def find_all_by_name(search_frag)
    all_merchants.select {|s| s.name.downcase.include? search_frag.downcase}
  end
end
