require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_transaction_repo_can_list_all_transaction
    t = TransactionRepository.new

    transaction_one = Transaction.new(test_helper_transaction_one_data)
    transaction_two = Transaction.new(test_helper_transaction_two_data)
    transaction_three = Transaction.new(test_helper_transaction_three_data)

    t.all_transactions << transaction_one
    t.all_transactions << transaction_two
    t.all_transactions << transaction_three

    assert_equal 3, t.all.length
    assert_equal Transaction, t.all.first.class
  end

  def test_transaction_repo_can_find_invoice_item_by_id
    transaction_repo = test_helper_transaction_repo
    assert_equal Transaction, transaction_repo.find_by_id(1).class
    assert_equal 2, transaction_repo.find_by_id(2).id
  end

  def test_transaction_repo_can_find_all_by_credit_card_number
    transaction_repo = test_helper_transaction_repo
    assert_equal Array, transaction_repo.find_all_by_credit_card_number(4558370000000000).class
    assert_equal Transaction, transaction_repo.find_all_by_credit_card_number(4558370000000000).first.class
    assert_equal 4558370000000000, transaction_repo.find_all_by_credit_card_number(4558370000000000).first.credit_card_number
  end

  def test_transaction_repo_can_find_all_by_result
    transaction_repo = test_helper_transaction_repo
    assert_equal Array, transaction_repo.find_all_by_result("failed").class
    assert_equal Transaction, transaction_repo.find_all_by_result("success").first.class
    assert_equal 10, transaction_repo.find_all_by_result("failed").length
  end

  def test_transaction_repo_can_find_all_by_date
    transaction_repo = test_helper_transaction_repo
    assert_equal 59, transaction_repo.find_all_by_date(Time.parse("2012-02-26")).length
  end
end
