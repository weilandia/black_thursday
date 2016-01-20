require_relative 'item'
require_relative 'data_parser'
require_relative 'repositories'

class ItemRepository
  include DataParser
  include Repositories
  attr_reader :all

  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{all_items.size} rows>"
  end

  def create_instance(item_data)
    item = Item.new(item_data)
    all_items << item
  end

  def all_items
    @all
  end

  def find_all_with_description(search_frag)
    all_items.select {|s| s.description.downcase.include? search_frag.downcase}
  end

  def find_all_by_price(price)
    all_items.select {|s| s.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    all_items.select do |s|
      s.unit_price <= range.last && s.unit_price >= range.first
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all_items.select {|s| s.merchant_id == merchant_id}
  end
end
