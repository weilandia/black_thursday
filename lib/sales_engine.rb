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

  def self.from_csv(data = data_files_hash)
    SalesEngine.new(data, :csv)
  end

  def self.from_json(data = data_files_hash)
    SalesEngine.new(data, :json)
  end

  def initialize(data, file_type)
    instantiate_repositories
    load_data(data, file_type) #DataParser module
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
