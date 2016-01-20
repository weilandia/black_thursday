require_relative 'transaction'
require_relative 'data_parser'
require_relative 'instantiate_repos'

class TransactionRepository
  include DataParser
  include InstantiateRepos
  attr_reader :all_transactions, :all
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

  def find_by_id(transaction_id)
    search_result = all.select {|s| s.id == transaction_id}[0]
    exact_search(search_result)
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

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end
end


# Collection of transactions
