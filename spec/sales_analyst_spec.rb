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
    assert_equal 1.2, @sales_analyst.average_items_per_merchant_standard_deviation
  end
end
