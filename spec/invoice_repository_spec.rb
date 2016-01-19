require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_invoice_repo_can_list_all_invoices
    i = InvoiceRepository.new

    invoice_one = Invoice.new(test_helper_invoice_one_data)
    invoice_two = Invoice.new(test_helper_invoice_two_data)
    invoice_three = Invoice.new(test_helper_invoice_three_data)

    i.all_invoices << invoice_one
    i.all_invoices << invoice_two
    i.all_invoices << invoice_three

    assert_equal 3, i.all.length
    assert_equal Invoice, i.all.first.class
  end

  def test_invoice_repo_can_find_invoice_by_id
    i = InvoiceRepository.new

    invoice_one = Invoice.new({id: 1})
    invoice_two = Invoice.new({id: 2})

    i.all_invoices << invoice_one
    i.all_invoices << invoice_two

    assert_equal invoice_one, i.find_by_id(1)
    assert_equal invoice_two, i.find_by_id(2)
  end

  def test_invoice_repo_can_find_invoice_by_customer_id
    i = InvoiceRepository.new

    invoice_one = Invoice.new({id: 1, customer_id: 10})
    invoice_two = Invoice.new({id: 2, customer_id: 10})

    i.all_invoices << invoice_one
    i.all_invoices << invoice_two

    assert_equal [invoice_one, invoice_two], i.find_all_by_customer_id(10)
  end

  def test_invoice_repo_can_find_invoice_by_merchant_id
    i = InvoiceRepository.new

    invoice_one = Invoice.new({id: 1, merchant_id: 20})
    invoice_two = Invoice.new({id: 2, merchant_id: 20})
    invoice_three = Invoice.new({id: 3, merchant_id: 21})

    i.all_invoices << invoice_one
    i.all_invoices << invoice_two
    i.all_invoices << invoice_three

    assert_equal [invoice_one, invoice_two], i.find_all_by_merchant_id(20)
    assert_equal [invoice_three], i.find_all_by_merchant_id(21)
  end

  def test_invoice_repo_can_find_invoice_by_status
    i = InvoiceRepository.new

    invoice_one = Invoice.new({id: 1, status: :pending})
    invoice_two = Invoice.new({id: 2, status: :pending})
    invoice_three = Invoice.new({id: 3, status: :shipped})

    i.all_invoices << invoice_one
    i.all_invoices << invoice_two
    i.all_invoices << invoice_three

    assert_equal [invoice_one, invoice_two], i.find_all_by_status(:pending)
    assert_equal [invoice_three], i.find_all_by_status(:shipped)
  end
end
