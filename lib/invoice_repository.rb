require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice'

class InvoiceRepository


  attr_reader :all_invoices
  def initialize(item_data = "data/items.csv")
    @all_items = []
    load_data(item_data)
  end

  def inspect
    "#<#{self.class} #{@all_items.size} rows>"
  end


end
