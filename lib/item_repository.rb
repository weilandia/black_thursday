require 'csv'
require 'bigdecimal'
require_relative '../lib/item'
require_relative 'data_parser'

class ItemRepository
  include DataParser
  attr_reader :all_items

  def initialize
    @all_items = []
  end

  def inspect
    "#<#{self.class} #{@all_items.size} rows>"
  end

  def create_instance(item_data)
    item = Item.new(item_data)
    @all_items << item
  end

  def all
    all_items
  end

  def find_by_name(merchant)
    result = @all_merchants.select {|s| s.name.downcase == merchant.downcase}[0]
    exact_search(result)
  end

  def find_by_id(item_id)
    search_result = @all_items.select {|search| search.id == item_id}[0]
    exact_search(search_result)
  end

  def find_by_merchant_id(merchant_id)
    @all_items.select {|search| search.merchant_id == merchant_id}
  end

  def find_by_name(item_name)
    result = @all_items.select {|s| s.name.downcase == item_name.downcase}[0]
    exact_search(result)
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_all_by_name(search_fragment)
    @all_items.select {|s| s.name.downcase.include? search_fragment.downcase}
  end

  def find_all_with_description(search_frag)
    @all_items.select {|s| s.description.downcase.include? search_frag.downcase}
  end

  def find_all_by_price(price)
    @all_items.select {|search| search.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    @all_items.select do |s|
      s.unit_price <= range.last && s.unit_price >= range.first
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all_items.select {|search| search.merchant_id == merchant_id}
  end
end
