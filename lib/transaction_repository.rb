require 'csv'
require 'bigdecimal'
require_relative '../lib/transaction'
class TransactionRepository

  attr_reader :all_transactions
  def initialize(transaction_data)
    @all_transactions = []
    load_data(transaction_data)
  end

  def inspect
    "#<#{self.class} #{@all_invoices.size} rows>"
  end

  def load_data(data)
    transactions = CSV.open data, headers: true, header_converters: :symbol
    transactions.each do |row|
      transaction_data =
      {:id => row[:id].to_i,
      :invoice_id => row[:invoice_id].to_i,
      :credit_card_number => row[:credit_card_number],
      :credit_card_expiration_date => row[:credit_card_expiration_date],
      :result => row[:result]
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}
      @all_transactions << Transaction.new(transaction_data)
    end
  end

  def all
    all_transactions
  end

  def find_by_id(transaction_id)
    search_result = all.select {|search| search.id == transaction_id}[0]
    exact_search(search_result)
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|search| search.invoice_id == invoice_id}
  end

  def find_all_by_find_all_by_credit_card_number(credit_card_number)
    all.select {|search| search.credit_card_number == credit_card_number}
  end

  def find_all_by_invoice_id(result)
    all.select {|search| search.result == result}
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end
end


# Collection of transactions
