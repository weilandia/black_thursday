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
    @sales_engine.from_csv(test_data_hash)
  end

  def test_sales_engine_object_has_merchant_repository_object
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

  def test_sales_engine_object_has_item_repository_object
    assert_equal ItemRepository, @sales_engine.items.class
  end

  def test_sales_engine_data_files_hash_method_defaults_correct_files
    assert_equal @sales_engine.data_files_hash[:merchants], "./data/merchants.csv"

    assert_equal @sales_engine.data_files_hash[:items], "./data/items.csv"
  end

  # Integrated SalesEngine tests
  def test_sales_engine_object_has_access_to_merhant_id
    merchant_id = @sales_engine.merchants.find_by_name("MiniatureBikez").id

    assert_equal "12334113", merchant_id
  end

  def test_sales_engine_object_has_access_to_merhant_name
    merchant_name = @sales_engine.merchants.find_by_id(12334113).name

    assert_equal "MiniatureBikez", merchant_name
  end

  def test_sales_engine_object_has_access_to_item_id
    item_id = @sales_engine.items.find_by_name("Very Magnifique").id

    assert_equal "263404435", item_id
  end

  def test_sales_engine_object_has_access_item_name
    item_name = @sales_engine.items.find_by_id(263404435).name

    assert_equal "Very Magnifique", item_name
  end
end
