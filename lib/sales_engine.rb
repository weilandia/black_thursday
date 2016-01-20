require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'data_parser'
require_relative 'merchant_relationships'
require_relative 'item_relationships'
require_relative 'invoice_relationships'
require_relative 'transaction_relationships'
require_relative 'customer_relationships'

class SalesEngine
  include DataParser
  include MerchantRelationships
  include ItemRelationships
  include InvoiceRelationships
  include TransactionRelationships
  include CustomerRelationships
  attr_reader :items,
              :invoices,
              :customers,
              :merchants,
              :transactions,
              :invoice_items

  def self.from_csv(data = csv_files_hash)
    sales_engine = SalesEngine.new
    sales_engine.load_data(data, :csv)
    sales_engine.relationships
    sales_engine
  end

  def self.from_json(data = json_files_hash)
    sales_engine = SalesEngine.new
    sales_engine.load_data(data, :json)
    sales_engine.relationships
    sales_engine
  end

  def initialize(data={})
    instantiate_repositories(data)
    relationships
  end

  def instantiate_repositories(tst_data)
    @items ||= ItemRepository.new(tst_data[:items] || [])
    @merchants ||= MerchantRepository.new(tst_data[:merchants] || [])
    @invoices ||= InvoiceRepository.new(tst_data[:invoices] || [])
    @invoice_items ||= InvoiceItemRepository.new(tst_data[:invoice_items] || [])
    @transactions ||= TransactionRepository.new(tst_data[:transactions] || [])
    @customers ||= CustomerRepository.new(tst_data[:customers] || [])
  end

  def relationships
    merchant_relationships
    item_relationships
    invoice_relationships
    transaction_relationships
    customer_relationships
    dependent_relationships #!!keep at bottom of relationships
  end

  def dependent_relationships
    merchant_revenue_relationship
  end

  def self.csv_files_hash
    { merchants: './data/merchants.csv',
      items: './data/items.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv' }
  end

  def self.json_files_hash
    { merchants: './data/merchants.json',
      items: './data/items.json',
      invoices: './data/invoices.json',
      invoice_items: './data/invoice_items.json',
      transactions: './data/transactions.json',
      customers: './data/customers.json' }
  end

  def inspect
    "#<#{self.class}:
    Items: #{@items.all.size}
    Merchants: #{@merchants.all.size}
    Invoices: #{@invoices.all.size}
    Invoice Items: #{@invoice_items.all.size}
    Transactions: #{@transactions.all.size}
    Customers: #{@customers.all.size}>"
  end
end
