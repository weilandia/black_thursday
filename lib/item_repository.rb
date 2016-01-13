require 'csv'
require 'bigdecimal'
require_relative '../lib/item'


class ItemRepository

  attr_reader :all_items, :merchant_repo
  def initialize(item_data = "data/items.csv")
    @all_items = []
    load_data(item_data)
  end

  def load_data(data)
    items = CSV.open data, headers: true, header_converters: :symbol

    items.each do |row|
      item_data= {:id => row[:id].to_i,
                  :name => row[:name],
                  :description => row[:description],
                  :unit_price => make_bigdecimal(row[:unit_price]),
                  :merchant_id => row[:merchant_id].to_i,
                  :created_at => row[:created_at],
                  :updated_at => row[:updated_at]
                }

      @all_items << Item.new(item_data)
    end
  end

  def make_bigdecimal(unit_price)
    BigDecimal.new("#{unit_price[0..-3]}.#{unit_price[-2..-1]}")
  end

  def inspect
    "#<#{self.class} #{@all_items.size} rows>"
  end

  def all
    all_items
  end

  def find_by_name(merchant_name)
    search_result = @all_merchants.select {|search| search.name.downcase == merchant_name.downcase}[0]
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(item_id)
    search_result = @all_items.select {|search| search.id == item_id}[0]
    return nil if search_result.nil?
    search_result
  end

  def find_by_merchant_id(merchant_id)
    @all_items.select {|search| search.merchant_id == merchant_id}
  end

  def find_by_name(item_name)
    search_result = @all_items.select {|search| search.name.downcase == item_name.downcase}[0]
    return nil if search_result.nil?
    search_result
  end

  def find_all_by_name(search_fragment)
    @all_items.select {|search| search.name.downcase.include? search_fragment.downcase}
  end

  def find_all_with_description(search_fragment)
    @all_items.select {|search| search.description.downcase.include? search_fragment.downcase}
  end

  def find_all_by_price(price)
    @all_items.select {|search| search.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    @all_items.select {|search| search.unit_price <= range.last && search.unit_price >= range.first}
  end

  def find_all_by_merchant_id(merchant_id)
    @all_items.select {|search| search.merchant_id == merchant_id}
  end
end
