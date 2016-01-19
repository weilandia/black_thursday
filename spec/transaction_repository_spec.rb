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
    t = TransactionRepository.new

    transaction_one = Transaction.new({id: 1})
    transaction_two = Transaction.new(id: 2)
    transaction_three = Transaction.new(id: 3)

    t.all_transactions << transaction_one
    t.all_transactions << transaction_two
    t.all_transactions << transaction_three

    assert_equal transaction_one, t.find_by_id(1)
    assert_equal Transaction, t.find_by_id(2).class
    assert_equal 3, t.find_by_id(3).id
  end

  def test_transaction_repo_can_find_all_by_credit_card_number
    t = TransactionRepository.new

    transaction_one = Transaction.new({id: 1, credit_card_number: 4558370000000000})
    transaction_two = Transaction.new(id: 2, credit_card_number: 4558370000000000)
    transaction_three = Transaction.new(id: 3, credit_card_number: 5558370000000000)

    t.all_transactions << transaction_one
    t.all_transactions << transaction_two
    t.all_transactions << transaction_three

    expected_transactions = [transaction_one, transaction_two]

    assert_equal expected_transactions, t.find_all_by_credit_card_number(4558370000000000)
  end

  def test_transaction_repo_can_find_all_by_result
    t = TransactionRepository.new

    transaction_one = Transaction.new({id: 1, result: "failed"})
    transaction_two = Transaction.new({id: 2, result: "failed"})
    transaction_three = Transaction.new({id: 3, result: "success"})

    t.all_transactions << transaction_one
    t.all_transactions << transaction_two
    t.all_transactions << transaction_three

    expected_failed = [transaction_one, transaction_two]
    expected_success = [transaction_three]

    assert_equal expected_failed, t.find_all_by_result("failed")
    assert_equal expected_success, t.find_all_by_result("success")
  end

  def test_transaction_repo_can_find_all_by_date
    t = TransactionRepository.new

    transaction_one = Transaction.new({id: 1, created_at: "2012-02-25"})
    transaction_two = Transaction.new({id: 2, created_at: "2012-02-26"})
    transaction_three = Transaction.new({id: 3, created_at: "2012-02-26"})

    t.all_transactions << transaction_one
    t.all_transactions << transaction_two
    t.all_transactions << transaction_three

    expected = [transaction_two, transaction_three]

    assert_equal expected, t.find_all_by_date(Time.parse("2012-02-26"))
  end
end
