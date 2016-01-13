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
      :status => row[:status],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at]}
      @all_invoices << Invoice.new(invoice_data)
    end
  end
end
