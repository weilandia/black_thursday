require_relative 'invoice'
require_relative 'data_parser'
require_relative 'repositories'

class InvoiceRepository
  include DataParser
  include Repositories
  attr_reader :all

  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{all_invoices.size} rows>"
  end

  def create_instance(invoice_data)
    invoice = Invoice.new(invoice_data)
    @all << invoice
  end

  def all_invoices
    @all
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|s| s.merchant_id == merchant_id}
  end

  def find_all_by_customer_id(customer_id)
    all.select {|s| s.customer_id == customer_id}
  end

  def find_all_by_status(status)
    all.select {|s| s.status == status}
  end

  def find_all_by_date(date)
    all.select {|s| s.created_at.to_s[0..9] == date.to_s[0..9]}
  end

  def find_all_by_updated_at_date(date)
    all.select {|s| s.updated_at.to_s[0..9] == date.to_s[0..9]}
  end
end
