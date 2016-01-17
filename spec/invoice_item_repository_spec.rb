require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_invoice_items_repo_can_list_all_invoice_items
    #Task: Decouple all repo tests like this test
    inv_itms = InvoiceItemRepository.new

    inv_itm_one = InvoiceItem.new(test_helper_invoice_item_one_data)
    inv_itm_two = InvoiceItem.new(test_helper_invoice_item_two_data)
    inv_itm_three = InvoiceItem.new(test_helper_invoice_item_three_data)

    inv_itms.all_invoice_items << inv_itm_one
    inv_itms.all_invoice_items << inv_itm_two
    inv_itms.all_invoice_items << inv_itm_three

    assert_equal 3, inv_itms.all.length
    assert_equal InvoiceItem, inv_itms.all.first.class
  end

  def test_invoice_items_repo_can_find_invoice_items_by_id
    inv_its_repo = InvoiceItemRepository.new
    inv_it_one = InvoiceItem.new(test_helper_invoice_item_one_data)
    inv_it_two = InvoiceItem.new(test_helper_invoice_item_two_data)

    inv_its_repo.all_invoice_items << inv_it_one
    inv_its_repo.all_invoice_items << inv_it_two

    assert_equal InvoiceItem, inv_its_repo.find_by_id(1).class
    assert_equal inv_it_two, inv_its_repo.find_by_id(2)
  end

  def test_invoice_items_repo_can_find_all_by_item_id
    inv_itms = InvoiceItemRepository.new
    inv_itm_one = InvoiceItem.new(test_helper_invoice_item_two_data)
    inv_itm_two = InvoiceItem.new({id: "3", item_id: "2", invoice_id: "1", quantity: "8", unit_price: "34873", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"})

    inv_itms.all_invoice_items << inv_itm_one
    inv_itms.all_invoice_items << inv_itm_two

    assert_equal InvoiceItem, inv_itms.find_all_by_item_id(2).first.class

    assert_equal [inv_itm_one, inv_itm_two], inv_itms.find_all_by_item_id(2)
  end

  def test_invoice_items_repo_can_find_all_by_invoice_id
    inv_itms = InvoiceItemRepository.new
    inv_itm_one = InvoiceItem.new(test_helper_invoice_item_three_data)
    inv_itm_two = InvoiceItem.new({id: "4", item_id: "2", invoice_id: "3", quantity: "8", unit_price: "34873", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"})

    inv_itms.all_invoice_items << inv_itm_one
    inv_itms.all_invoice_items << inv_itm_two

    assert_equal InvoiceItem, inv_itms.find_all_by_invoice_id(3).first.class
    assert_equal [inv_itm_one, inv_itm_two], inv_itms.find_all_by_invoice_id(3)
  end
end
