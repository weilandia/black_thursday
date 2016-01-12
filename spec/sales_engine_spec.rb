require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    test_data_hash = {:merchants => "./test_data/merchant_test.csv",
            :items => "./test_data/item_test.csv"
            }
    @sales_engine = SalesEngine.new
    @sales_engine.load_data(test_data_hash)
  end

  def test_sales_engine_object_has_merchant_repository_object
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

  def test_sales_engine_object_has_item_repository_object
    assert_equal ItemRepository, @sales_engine.items.class
  end
end
