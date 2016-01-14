require 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_has_access_to_sales_engine
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal SalesEngine, sales_analyst.engine.class
  end

  def test_sales_analyst_can_calculate_total_number_of_merchants
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 6, sales_analyst.total_merchant_count
  end

  def test_sales_analyst_can_calculate_total_number_of_items
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 15, sales_analyst.total_item_count
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 2.5, sales_analyst.average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_standard_deviation_of_average_items_per_merchant
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 2.07, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_identify_merchants_with_few_items
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    merchants = sales_analyst.merchants_with_low_item_count
    assert_equal [], merchants.map { |m| m.name }
  end

  def test_sales_analyst_identifies_average_item_price_per_merchant
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 411.25, sales_analyst.average_item_price_for_merchant(12334144)
  end

  def test_sales_analyst_can_calculate_average_price_per_merchant
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal 109.67, sales_analyst.average_price_per_merchant.to_f
  end

  def test_sales_analyst_calculate_golden_items_two_standard_devs
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)
    assert_equal ["Very Magnifique"], sales_analyst.golden_items.map { |item| item.name }
  end

  def test_sales_analyst_calculates_invoices_per_merchant
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    assert_equal SOMENUMBER, sales_analyst.average_invoices_per_merchant
  end

  def test_sales_analyst_calculates_average_invoices_per_merchant_standard_deviation
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    assert_equal SOMENUMBER,
    sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_sales_analyst_calculates_top_merchants_by_invoice_count
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    top_merchants = sales_analyst.top_merchants_by_invoice_count

    two_standard_deviations_above = (sales_analyst.average_invoices_per_merchant + (2 * sales_analyst.average_invoices_per_merchant_standard_deviation))

    assert_equal Array, top_merchants.class
    assert_equal Merchant, top_merchants.first.class
    assert top_merchants.last.invoices.count > two_standard_deviations_above
  end

  def test_sales_analyst_calculates_bottom_merchants_by_invoice_count
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    bottom_merchants = sales_analyst.bottom_merchants_by_invoice_count

    two_standard_deviations_below = (sales_analyst.average_invoices_per_merchant - (2 * sales_analyst.average_invoices_per_merchant_standard_deviation))

    assert_equal Array, bottom_merchants.class
    assert_equal Merchant, bottom_merchants.first.class
    assert bottom_merchants.last.invoices.count < two_standard_deviations_below
  end

  def test_sales_analyst_calculates_top_days_by_invoice_count
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    one_standard_deviations_above = sales_analyst.average_invoices_per_merchant + sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal Array, sales_analyst.top_days_by_invoice_count.class
    assert_equal String, sales_analyst.top_days_by_invoice_count.first.class

    assert sales_analyst.invoice_count_by_day(top_days_by_invoice_count.last) > one_standard_deviations_above
  end

  def test_sales_analyst_calculates_invoices_status_percentages
    sales_analyst = SalesAnalyst.new(test_helper_sales_engine)

    assert_equal Float, sales_analyst.invoice_status(:pending).class

    invoice_count = sales_analyst.total_invoice_count

    status_count = sales_analyst.invoice_count_by_status

    assert_equal SOMENUMBER, (status_count/invoice_count) * 100
  end
end
