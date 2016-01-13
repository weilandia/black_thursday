require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new(test_helper_csv_hash)
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_sales_analyst_has_access_to_sales_engine
    assert_equal SalesEngine, @sales_analyst.engine.class
  end

  def test_sales_analyst_can_calculate_total_number_of_merchants
    assert_equal 6, @sales_analyst.total_merchant_count
  end

  def test_sales_analyst_can_calculate_total_number_of_items
    assert_equal 15, @sales_analyst.total_item_count
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    assert_equal 2.5, @sales_analyst.average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_standard_deviation_of_average_items_per_merchant
    assert_equal 1.89, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_identify_merchants_with_few_items
    merchants = @sales_analyst.merchants_with_low_item_count
    assert_equal ["Candisart", "MiniatureBikez", "GoldenRayPress"], merchants.map { |m| m.name }
  end

  def test_sales_analyst_identifies_average_item_price_per_merchant
    assert_equal 411.25, @sales_analyst.average_item_price_for_merchant(12334144)
  end

  def test_sales_analyst_can_calculate_average_price_per_merchant
    assert_equal 109.67, @sales_analyst.average_price_per_merchant.to_f
  end

  def test_sales_analyst_calculate_golden_items_two_standard_devs
    assert_equal ["Very Magnifique"], @sales_analyst.golden_items
  end
end
