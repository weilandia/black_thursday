require_relative 'invoice_item'
require_relative 'data_parser'
require_relative 'repositories'

class InvoiceItemRepository
  include DataParser
  include Repositories
  attr_reader :all

  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{all_invoice_items.size} rows>"
  end

  def create_instance(invoice_items_data)
    invoice_items = InvoiceItem.new(invoice_items_data)
    @all << invoice_items
  end

  def all_invoice_items
    @all
  end

  def find_all_by_item_id(item_id)
    all.select {|s| s.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|s| s.invoice_id == invoice_id}
  end
end
