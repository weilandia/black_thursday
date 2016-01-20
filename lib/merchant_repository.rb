require_relative 'merchant'
require_relative 'data_parser'
require_relative 'repositories'

class MerchantRepository
  include DataParser
  include Repositories
  attr_reader :all

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
end
