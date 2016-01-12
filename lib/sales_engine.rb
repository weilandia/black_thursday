$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'merchant_repository'
require 'item_repository'

class SalesEngine
  attr_reader :merchants, :items

  def data_files_hash
    data = {:merchants => "./data/merchants.csv",
            :items => "./data/items.csv"
            }
    data
  end

  def from_csv(data = data_files_hash)
    @merchants = MerchantRepository.new(data[:merchants])
    @items = ItemRepository.new(data[:items])
  end
end
