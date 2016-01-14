require 'minitest/autorun'; require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_invoice_repo_can_list_all_invoices
    invoice_repo = test_helper_invoice_repo
    assert_equal 25, invoice_repo.all.length
    assert_equal Invoice, invoice_repo.all.first.class
  end

  def test_invoice_repo_can_find_invoice_by_id
    invoice_repo = test_helper_invoice_repo
    assert_equal Invoice, invoice_repo.find_by_id(1).class
    assert_equal 2, invoice_repo.find_by_id(2).id
  end

  def test_invoice_repo_can_find_invoice_by_customer_id
    invoice_repo = test_helper_invoice_repo
    assert_equal Array, invoice_repo.find_all_by_customer_id(1).class
    assert_equal Invoice, invoice_repo.find_all_by_customer_id(1).first.class
    assert_equal 8, invoice_repo.find_all_by_customer_id(1).length
  end

  def test_invoice_repo_can_find_invoice_by_merchant_id
    invoice_repo = test_helper_invoice_repo
    assert_equal Array, invoice_repo.find_all_by_merchant_id(12335955).class
    assert_equal Invoice, invoice_repo.find_all_by_merchant_id(12335955).first.class
    assert_equal 2, invoice_repo.find_all_by_merchant_id(12335955).length
  end

  def test_invoice_repo_can_find_invoice_by_status
    invoice_repo = test_helper_invoice_repo
    assert_equal Array, invoice_repo.find_all_by_status("pending").class
    assert_equal Invoice, invoice_repo.find_all_by_status("pending").first.class
    assert_equal 10, invoice_repo.find_all_by_status("pending").length
  end

  def test_invoice_repo_can_find_invoice_by_status_all_statuses
    invoice_repo = test_helper_invoice_repo
    assert_equal 10, invoice_repo.find_all_by_status("pending").length
    assert_equal 14, invoice_repo.find_all_by_status("shipped").length
    assert_equal 1, invoice_repo.find_all_by_status("returned").length
    assert_equal 0, invoice_repo.find_all_by_status("nil").length
  end
end
