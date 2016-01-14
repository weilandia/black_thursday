require 'coveralls'; Coveralls.wear!
require 'simplecov'; SimpleCov.start
require 'minitest/autorun'; require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_invoice_can_query_id
    invoice = test_helper_invoice
    assert_equal 11, invoice.id
  end

  def test_invoice_can_query_customer_id
    invoice = test_helper_invoice
    assert_equal 2, invoice.customer_id
  end

  def test_invoice_can_query_merchant_id
    invoice = test_helper_invoice
    assert_equal 12334771, invoice.merchant_id
  end

  def test_invoice_can_query_status
    invoice = test_helper_invoice
    assert_equal "pending", invoice.status
  end

  def test_invoice_can_query_creation_date
    invoice = test_helper_invoice
    assert_equal Time.new("2016-01-11 12:22:31 UTC"), invoice.created_at
  end

  def test_invoice_can_query_date_of_last_update
    invoice = test_helper_invoice
    assert_equal Time.new("2016-01-01 00:00:00 -0700"), invoice.updated_at
  end
end
