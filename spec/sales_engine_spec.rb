require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
  end

  def test_sales_engine_object_has_merchant_repository_object
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

  def test_sales_engine_object_has_item_repository_object
    assert_equal ItemRepository, @sales_engine.items.class
  end

  def test_sales_engine_data_files_hash_method_defaults_correct_files
    assert_equal SalesEngine.data_files_hash[:merchants], "./data/merchants.csv"

    assert_equal SalesEngine.data_files_hash[:items], "./data/items.csv"
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

  def test_sales_engine_object_has_access_an_items_merchant_id
    item_merchant_id = @sales_engine.items.find_by_id(263404435).merchant_id

    assert_equal "12334144", item_merchant_id
  end

  def test_sales_engine_object_has_access_an_item_unit_price
    item_unit_price = @sales_engine.items.find_by_id(263404435).unit_price

    assert_equal "80000", item_unit_price
  end

  def test_sales_engines_creates_merchants_that_have_access_to_items
    merchant = @sales_engine.merchants.find_by_id(12334105)
    assert_equal Array, merchant.items.class
    assert_equal 6, merchant.items.length
    assert_equal "TestItemOne", merchant.items[0].name
    assert_equal "TestItemTwo", merchant.items[1].name
    assert_equal "TestItemThree", merchant.items[2].name
    assert_equal "SalesAnalystItemZero", merchant.items[3].name
  end

  def test_sales_engines_creates_items_that_have_access_to_merchants
    item = @sales_engine.items.find_by_id(1000)
    assert_equal Merchant, item.merchant.class
    assert_equal "Shopin1901", item.merchant.name
  end
end
