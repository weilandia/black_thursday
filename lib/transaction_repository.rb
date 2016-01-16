require 'csv'
require 'bigdecimal'
require_relative '../lib/transaction'
require_relative 'data_parser'

class TransactionRepository
  include DataParser
  attr_reader :all_transactions
  def initialize
    @all_transactions = []
  end

  def inspect
    "#<#{self.class} #{@all_transactions.size} rows>"
  end

  def create_instance(transaction_data)
    transaction = Transaction.new(transaction_data)
    @all_transactions << transaction
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

  def find_all_by_credit_card_number(credit_card_number)
    all.select {|search| search.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    all.select {|search| search.result == result}
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end
end


# Collection of transactions
