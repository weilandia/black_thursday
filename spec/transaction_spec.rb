require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def test_transaction_can_query_id
    transaction = test_helper_transaction
    assert_equal 3, transaction.id
  end

  def test_transaction_can_query_invoice_id
    transaction = test_helper_transaction
    assert_equal 3, transaction.invoice_id
  end

  def test_transaction_can_query_credit_card_number
    transaction = test_helper_transaction
    assert_equal "4271810000000000", transaction.credit_card_number
  end

  def test_transaction_can_query_credit_card_expiration_date
    transaction = test_helper_transaction
    assert_equal "1220", transaction.credit_card_expiration_date
  end

  def test_transaction_can_query_result
    transaction = test_helper_transaction
    assert_equal "success", transaction.result
  end

  def test_transaction_can_query_creation_date
    transaction = test_helper_transaction
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.created_at
  end

  def test_transaction_can_query_date_of_last_update
    transaction = test_helper_transaction
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), transaction.updated_at
  end
end
