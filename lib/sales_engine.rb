require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(csv_data)
    load_data(csv_data)
    relationships
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
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def relationships
    merchant_item_relationship
    item_merchant_relationship
  end

  def merchant_item_relationship
    merchants.all.each do |merchant|
      merchant.items = items.find_all_by_merchant_id(merchant.id)
    end
  end

  def item_merchant_relationship
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end
end
