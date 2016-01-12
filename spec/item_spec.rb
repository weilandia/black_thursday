require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    item_data = {:id => "263401607",
                :name => "Amy Winehouse drawing print",
                :description => "Print of ink drawing on card of amy winehouse\nA4 or A5 prints available",
                :unit_price => "2000",
                :merchant_id => "12334397",
                :created_at => "2016-01-11 12:22:31 UTC",
                :updated_at => "2012-03-27 14:53:59 UTC"
              }
    @item = Item.new(item_data)
  end

  def test_item_can_query_id
    assert_equal "263401607", @item.id
  end

  def test_item_can_query_name
    assert_equal "Amy Winehouse drawing print", @item.name
  end

  def test_item_can_query_description
    assert_equal "Print of ink drawing on card of amy winehouse\nA4 or A5 prints available", @item.description
  end

  def test_item_can_query_unit_price
    assert_equal "2000", @item.unit_price
  end

  def test_item_can_query_merchant_id
    assert_equal "12334397", @item.merchant_id
  end

  def test_item_can_query_creation_date
    assert_equal "2016-01-11 12:22:31 UTC", @item.created_at
  end

  def test_item_can_query_date_of_last_updated
    assert_equal "2012-03-27 14:53:59 UTC", @item.updated_at
  end
end
