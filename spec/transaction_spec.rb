require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def test_transaction_can_query_id
    transaction = Transaction.new(test_helper_transaction_one_data)
    assert_equal 1, transaction.id
  end

  def test_transaction_can_query_invoice_id
    transaction = Transaction.new(test_helper_transaction_two_data)
    assert_equal 2, transaction.invoice_id
  end

  def test_transaction_can_query_credit_card_number
    transaction = Transaction.new(test_helper_transaction_three_data)
    assert_equal "3333333333333333", transaction.credit_card_number
  end

  def test_transaction_can_query_credit_card_expiration_date
    transaction = Transaction.new(test_helper_transaction_one_data)
    assert_equal "1111", transaction.credit_card_expiration_date
  end

  def test_transaction_can_query_result
    transaction = Transaction.new(test_helper_transaction_two_data)
    assert_equal "failed", transaction.result
  end

  def test_transaction_can_query_creation_date
    transaction = Transaction.new(test_helper_transaction_three_data)
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.created_at
  end

  def test_transaction_can_query_date_of_last_update
    transaction = Transaction.new(test_helper_transaction_one_data)
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.updated_at
  end
end
