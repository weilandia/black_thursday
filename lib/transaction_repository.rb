require_relative 'transaction'
require_relative 'data_parser'
require_relative 'repositories'

class TransactionRepository
  include DataParser
  include Repositories
  attr_reader :all
  
  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{@all_transactions.size} rows>"
  end

  def create_instance(transaction_data)
    transaction = Transaction.new(transaction_data)
    @all << transaction
  end

  def all_transactions
    @all
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|s| s.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select { |s| s.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    all.select {|s| s.result == result}
  end

  def find_all_by_date(date)
    all.select {|s| s.created_at.to_s[0..9] == date.to_s[0..9]}
  end
end
