require 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_item_can_query_id
    item = Item.new(test_helper_item_one_data)
    assert_equal 1, item.id
  end

  def test_item_can_query_name
    item = Item.new(test_helper_item_two_data)
    assert_equal "Item 2", item.name
  end

  def test_item_can_query_description
    item = Item.new(test_helper_item_three_data)
    assert_equal "Item Three Description", item.description
  end

  def test_item_can_query_merchant_id
    item = Item.new(test_helper_item_one_data)
    assert_equal 1, item.merchant_id
  end

  def test_item_can_query_creation_date
    item = Item.new(test_helper_item_one_data)
    assert_equal Time.parse("2016-01-11 12:22:31 UTC"), item.created_at
  end

  def test_item_can_query_date_of_last_update
    item = Item.new(test_helper_item_one_data)
    assert_equal Time.parse("2012-03-27 14:53:59 UTC"), item.updated_at
  end
end
