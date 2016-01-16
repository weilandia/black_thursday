require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice_item'
require_relative 'data_parser'

class InvoiceItemRepository
  include DataParser
  attr_reader :all_invoice_items

  def initialize
    @all_invoice_items = []
  end

  def inspect
    "#<#{self.class} #{@all_invoice_items.size} rows>"
  end

  def create_instance(invoice_items_data)
    invoice_items = InvoiceItem.new(invoice_items_data)
    @all_invoice_items << invoice_items
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
