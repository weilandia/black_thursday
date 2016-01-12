require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class MerchantTest < Minitest::Test
  def setup
    test_data_hash = {:merchants => "./test_data/merchant_test.csv",
            :items => "./test_data/item_test.csv"
            }
    @sales_engine = SalesEngine.from_csv(test_data_hash)
    merchant_data = {:id => "12334105",
                :name => "Shopin1901",
                :created_at => "2016-01-11 10:37:09 UTC",
                :updated_at => "2016-01-11 10:37:09 UTC"
              }

    item_repo = ItemRepository.new("test_data/item_test.csv")
    @merchant = Merchant.new(merchant_data, item_repo)
  end

  def test_merchant_can_query_id
    assert_equal "12334105", @merchant.id
  end

  def test_merchant_can_query_name
    assert_equal "Shopin1901", @merchant.name
  end

  def test_merchant_can_query_creation_date
    assert_equal "2016-01-11 10:37:09 UTC", @merchant.created_at
  end

  def test_merchant_can_query_date_of_last_update
    assert_equal "2016-01-11 10:37:09 UTC", @merchant.updated_at
  end

  def test_merchant_can_list_an_item
    item_one_object = Item.new({:id => "263467489",
                :name => "TestItem",
                :description => "This is a test item",
                :unit_price => "40000",
                :merchant_id => "12334115",
                :created_at => "2016-01-11 11:44:13 UTC",
                :updated_at => "1990-10-06 04:14:15 UTC"
              })
    merchant = @sales_engine.merchants.find_by_id(12334115)
    assert_equal item_one_object.name, merchant.items[0].name
  end
end
