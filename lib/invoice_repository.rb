require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice'
class InvoiceRepository

  attr_reader :all_invoices
  def initialize(invoice_data)
    @all_invoices = []
    load_data(invoice_data)
  end

  def inspect
    "#<#{self.class} #{@all_invoices.size} rows>"
  end

  def load_data(data)
    invoices = CSV.open data, headers: true, header_converters: :symbol
    invoices.each do |row|
      invoice_data =
      {:id => row[:id].to_i,
      :customer_id => row[:customer_id].to_i,
      :merchant_id => row[:merchant_id].to_i,
      :status => row[:status].to_sym,
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}
      @all_invoices << Invoice.new(invoice_data)
    end
  end

  def all
    all_invoices
  end

  def find_by_id(invoice_id)
    search_result = all.select {|search| search.id == invoice_id}[0]
    exact_search(search_result)
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|search| search.merchant_id == merchant_id}
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_all_by_customer_id(customer_id)
    all.select {|search| search.customer_id == customer_id}
  end

  def find_all_by_status(status)
    all.select {|search| search.status == status}
  end

end
