require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'data_parser'

class SalesEngine
  include DataParser
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions,
  :customers

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

  def initialize
    instantiate_repositories
  end

  def instantiate_repositories
    @items ||= ItemRepository.new
    @merchants ||= MerchantRepository.new
    @invoices ||= InvoiceRepository.new
    @invoice_items ||= InvoiceItemRepository.new
    @transactions ||= TransactionRepository.new
    @customers ||= CustomerRepository.new
  end

  def relationships
    merchant_item_relationship
    item_merchant_relationship
    invoice_merchant_relationship
    merchant_invoice_relationship
    invoice_item_relationship
    invoice_transaction_relationship
    invoice_customer_relationship
    transaction_invoice_relationship
    merchant_customer_relationship
    customer_merchant_relationship
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

  def merchant_invoice_relationship
    merchants.all.each do |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)
    end
  end

  def invoice_merchant_relationship
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
    end
  end

  def invoice_customer_relationship
    invoices.all.each do |invoice|
      invoice.customer = customers.find_by_id(invoice.customer_id)
    end
  end

  def invoice_item_relationship
    item_ids = []
    invoices.all.each do |invoice|
      inv_items = invoice_items.find_all_by_invoice_id(invoice.id)
    item_ids = inv_items.map { |inv_item| inv_item.item_id}
    invoice.items = item_ids.map { |item_id| items.find_by_id(item_id)}
    end
  end

  def merchant_customer_relationship
    cust_ids = []
    merchants.all.each do |merchant|
      invs = invoices.find_all_by_merchant_id(merchant.id)
      cust_ids = invs.map { |inv| inv.customer_id}.uniq
      merchant.customers = cust_ids.map { |id| customers.find_by_id(id)}
    end
  end

  def customer_merchant_relationship
    merch_ids = []
    customers.all.each do |customer|
      invs = invoices.find_all_by_customer_id(customer.id)
      merch_ids = invs.map { |inv| inv.merchant_id}.uniq
      customer.merchants = merch_ids.map { |id| merchants.find_by_id(id)}
    end
  end

  def invoice_transaction_relationship
    invoices.all.each do |invoice|
      invoice.transactions = transactions.find_all_by_invoice_id(invoice.id)
    end
  end

  def transaction_invoice_relationship
    transactions.all.each do |transaction|
      transaction.invoice = invoices.find_by_id(transaction.invoice_id)
    end
  end


  def self.csv_files_hash
    {:merchants => "./data/merchants.csv",
    :items => "./data/items.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"}
  end

  def self.json_files_hash
    {:merchants => "./data/merchants.json",
    :items => "./data/items.json",
    :invoices => "./data/invoices.json",
    :invoice_items => "./data/invoice_items.json",
    :transactions => "./data/transactions.json",
    :customers => "./data/customers.json"}
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
