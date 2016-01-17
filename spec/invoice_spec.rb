require 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_invoice_can_query_id
    invoice = Invoice.new(test_helper_invoice_one_data)
    assert_equal 1, invoice.id
  end

  def test_invoice_can_query_customer_id
    invoice = Invoice.new(test_helper_invoice_two_data)
    assert_equal 2, invoice.customer_id
  end

  def test_invoice_can_query_merchant_id
    invoice = Invoice.new(test_helper_invoice_three_data)
    assert_equal 3, invoice.merchant_id
  end

  def test_invoice_can_query_status
    invoice = Invoice.new(test_helper_invoice_one_data)
    assert_equal :pending, invoice.status
  end

  def test_invoice_can_query_creation_date
    invoice = Invoice.new(test_helper_invoice_two_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), invoice.created_at
  end

  def test_invoice_can_query_date_of_last_update
    invoice = Invoice.new(test_helper_invoice_three_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), invoice.updated_at
  end
end
