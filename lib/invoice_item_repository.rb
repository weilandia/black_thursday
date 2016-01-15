require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice_item'
class InvoiceItemRepository

  attr_reader :all_invoice_items

  def from_csv(invoice_item_data = "./data/invoice_items.csv")
    @all_invoice_items = []
    load_data(invoice_item_data)
  end

  def inspect
    "#<#{self.class} #{@all_invoice_items.size} rows>"
  end

  def load_data(data)
    invoice_items = CSV.open data, headers: true, header_converters: :symbol
    invoice_items.each do |row|
      invoice_item_data =
      {:id => row[:id].to_i,
      :item_id => row[:item_id].to_i,
      :invoice_id => row[:invoice_id].to_i,
      :quantity => row[:quantity].to_i,
      :unit_price => make_bigdecimal(row[:unit_price]),
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}
      @all_invoice_items << InvoiceItem.new(invoice_item_data)
    end
  end

  def make_bigdecimal(unit_price)
    BigDecimal.new("#{unit_price[0..-3]}.#{unit_price[-2..-1]}")
  end

  def all
    all_invoice_items
  end

  def find_by_id(invoice_item_id)
    search_result = all.select {|search| search.id == invoice_item_id}[0]
    exact_search(search_result)
  end

  def find_all_by_item_id(item_id)
    all.select {|search| search.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|search| search.invoice_id == invoice_id}
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end
end
