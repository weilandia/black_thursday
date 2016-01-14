require 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item_one = Item.new(test_helper_item_one_data)
    @item_two = Item.new(test_helper_item_two_data)
    @item_three = Item.new(test_helper_item_three_data)
  end

  def test_item_can_query_id
    assert_equal "0001", @item_one.id
  end

  def test_item_can_query_name
    assert_equal "Test Item 2", @item_two.name
  end

  def test_item_can_query_description
    assert_equal "This is our third test item!", @item_three.description
  end

  def test_item_can_query_merchant_id
    assert_equal "12334105", @item_one.merchant_id
  end

  def test_item_can_query_creation_date
    assert_equal Time.parse("2016-01-11 12:22:31 UTC"), @item_one.created_at
  end

  def test_item_can_query_date_of_last_update
    assert_equal Time.parse("2012-03-27 14:53:59 UTC"), @item_one.updated_at
  end

end
