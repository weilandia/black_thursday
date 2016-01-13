require "csv"
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
                  :unit_price => row[:unit_price],
                  :merchant_id => row[:merchant_id].to_i,
                  :created_at => row[:created_at],
                  :updated_at => row[:updated_at]
                }

      @all_items << Item.new(item_data)
    end
  end

  def inspect
    "#<#{self.class} #{@all_items.size} rows>"
  end

  def load_merchant_repo(merchant_repo)
    @merchant_repo = merchant_repo
    @all_items.each do |item|
      merchant_id = item.merchant_id
      item.load_merchant(merchant_repo.find_by_id(merchant_id))
    end
  end

  def all
    @all_items
  end

  def find_by_id(item_id)
    search_result = @all_items.select {|search| search.id == item_id}
    exact_item_search(search_result)
  end

  def find_by_merchant_id(merchant_id)
    @all_items.select {|search| search.merchant_id == merchant_id}
  end

  def find_by_name(item_name)
    search_result = @all_items.select {|search| search.name.downcase == item_name.downcase}
    exact_item_search(search_result)
  end

  def exact_item_search(search_result)
    if search_result.empty? == true
      search_result = nil
    else
      search_result = search_result[0]
    end
    search_result
  end

  def find_all_by_name(search_fragment)
    @all_items.select {|search| search.name.downcase.include? search_fragment.downcase}
  end

  def find_all_with_description(search_fragment)
    @all_items.select {|search| search.description.downcase.include? search_fragment.downcase}
  end
end
