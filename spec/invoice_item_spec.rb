require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_can_query_id
    invoice_item = InvoiceItem.new(test_helper_invoice_item_one_data)
    assert_equal 1, invoice_item.id
  end

  def test_invoice_item_can_query_item_id
    invoice_item = InvoiceItem.new(test_helper_invoice_item_two_data)
    assert_equal 2, invoice_item.item_id
  end

  def test_invoice_item_can_query_invoice_id
    invoice_item = InvoiceItem.new(test_helper_invoice_item_three_data)
    assert_equal 3, invoice_item.invoice_id
  end

  def test_invoice_item_can_query_quantity
    invoice_item = InvoiceItem.new(test_helper_invoice_item_one_data)
    assert_equal 1, invoice_item.quantity
  end

  def test_invoice_item_can_query_unit_price
    invoice_item = InvoiceItem.new(test_helper_invoice_item_two_data)
    assert_equal 200.00, invoice_item.unit_price.to_f
  end

  def test_invoice_item_can_query_creation_date
    invoice_item = InvoiceItem.new(test_helper_invoice_item_three_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), invoice_item.created_at
  end

  def test_invoice_item_can_query_date_of_last_update
    invoice_item = InvoiceItem.new(test_helper_invoice_item_one_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), invoice_item.updated_at
  end
end
