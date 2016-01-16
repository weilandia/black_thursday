require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_analyst'

class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions,
  :customers

  def self.from_csv(data = data_files_hash)
    @s ||= SalesEngine.new(data)
  end

  def self.data_files_hash
    {:merchants => "./data/merchants.csv",
    :items => "./data/items.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"}
  end

  def initialize(csv_data)
    instantiate_repositories
    load_data(csv_data)
    relationships
  end

  def instantiate_repositories
    @items ||= ItemRepository.new
    @merchants ||= MerchantRepository.new
    @invoices ||= InvoiceRepository.new
    @invoice_items ||= InvoiceItemRepository.new
    @transactions ||= TransactionRepository.new
    @customers ||= CustomerRepository.new
  end

  def load_data(data)
    @items.from_csv(data[:items])
    @merchants.from_csv(data[:merchants])
    @invoices.from_csv(data[:invoices])
    @invoice_items.from_csv(data[:invoice_items])
    @transactions.from_csv(data[:transactions])
    @customers.from_csv(data[:customers])
  end

  def relationships
    merchant_item_relationship
    item_merchant_relationship
    invoice_merchant_relationship
    merchant_invoice_relationship
    invoice_item_relationship
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

  def invoice_item_relationship
    item_ids = []
    invoices.all.each do |invoice|
      inv_items = invoice_items.find_all_by_invoice_id(invoice.id)
    item_ids = inv_items.map { |inv_item| inv_item.item_id}
    invoice.items = item_ids.map { |item_id| items.find_by_id(item_id)}
    end
  end
end
