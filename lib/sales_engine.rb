require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(csv_data)
    load_data(csv_data)
  end

  def self.from_csv(data = data_files_hash)
    SalesEngine.new(data)
  end

  def self.data_files_hash
    data = {:merchants => "./data/merchants.csv",
            :items => "./data/items.csv"
            }
    data
  end

  def load_data(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants], @items)
    @items.load_merchant_repo(@merchants)
  end
end
