require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_invoice_items_repo_can_list_all_invoice_items
    invoice_items = CSV.open "./test_data/invoice_item_test.csv", headers: true, header_converters: :symbol
    invoice_items_repo = test_helper_invoice_items_repo
    assert_equal invoice_items.count, invoice_items_repo.all.length
    assert_equal InvoiceItem, invoice_items_repo.all.first.class
  end

  def test_invoice_items_repo_can_find_invoice_items_by_id
    invoice_items_repo = test_helper_invoice_items_repo
    assert_equal InvoiceItem, invoice_items_repo.find_by_id(1).class
    assert_equal 2, invoice_items_repo.find_by_id(2).id
  end

  def test_invoice_items_repo_can_find_all_by_item_id
    invoice_items_repo = test_helper_invoice_items_repo
    assert_equal Array, invoice_items_repo.find_all_by_item_id(1).class
    assert_equal InvoiceItem, invoice_items_repo.find_all_by_item_id(1).first.class
    assert_equal 9, invoice_items_repo.find_all_by_item_id(1).length
  end

  def test_invoice_items_repo_can_find_all_by_invoice_id
    invoice_items_repo = test_helper_invoice_items_repo
    assert_equal Array, invoice_items_repo.find_all_by_invoice_id(1).class
    assert_equal InvoiceItem, invoice_items_repo.find_all_by_invoice_id(1).first.class
    assert_equal 8, invoice_items_repo.find_all_by_invoice_id(1).length
  end
end
