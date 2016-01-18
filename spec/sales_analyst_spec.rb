require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_has_access_to_sales_engine
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal SalesEngine, sales_analyst.engine.class
  end

  def test_sales_analyst_can_calculate_total_number_of_merchants
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 15, sales_analyst.total_merchant_count
  end

  def test_sales_analyst_can_calculate_total_number_of_items
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 39, sales_analyst.total_item_count
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 2.6, sales_analyst.average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_standard_deviation_of_average_items_per_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 4.07, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_identify_merchants_with_few_items
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    merchants = sales_analyst.merchants_with_low_item_count
    assert_equal [], merchants.map { |m| m.name }
  end

  def test_sales_analyst_can_identify_merchants_with_high_item_counts
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    merchants = sales_analyst.merchants_with_high_item_count
    assert_equal ["Shopin1901", "Got"], merchants.map { |m| m.name }
  end

  def test_sales_analyst_identifies_average_item_price_per_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 327.14, sales_analyst.average_item_price_for_merchant(1).to_f
  end

  def test_sales_analyst_can_calculate_average_average_price_per_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 73.25, sales_analyst.average_average_price_per_merchant
  end

  def test_sales_analyst_calculate_golden_items_two_standard_devs
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal ["Very Magnifique", "TestItem28", "TestItem29"], sales_analyst.golden_items.map { |item| item.name }
  end

  def test_sales_analyst_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 3.33, sales_analyst.average_invoices_per_merchant
  end

  def test_sales_analyst_calculates_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 1.63,
    sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_sales_analyst_calculates_top_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_merchants = sales_analyst.top_merchants_by_invoice_count

    two_standard_deviations_above = (sales_analyst.average_invoices_per_merchant + (2 * sales_analyst.average_invoices_per_merchant_standard_deviation))

    assert_equal Array, top_merchants.class
    assert_equal Merchant, top_merchants.first.class
    assert_equal [8], top_merchants.map { |m| m.invoices.count }
    assert top_merchants.last.invoices.count > two_standard_deviations_above

    assert_equal "Got", top_merchants.first.name
  end

  def test_sales_analyst_calculates_bottom_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    bottom_merchants = sales_analyst.bottom_merchants_by_invoice_count

    two_standard_deviations_below = (sales_analyst.average_invoices_per_merchant - (2 * sales_analyst.average_invoices_per_merchant_standard_deviation))

    assert_equal Array, bottom_merchants.class
    assert_equal Merchant, bottom_merchants.first.class
    assert bottom_merchants.last.invoices.count < two_standard_deviations_below

    assert_equal "Shopin1901", bottom_merchants.first.name
  end

  def test_sales_analyst_calculates_invoice_count_per_day
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    days_hash = {"Tuesday"=>8, "Monday"=>13, "Thursday"=>21, "Wednesday"=>3, "Saturday"=>4, "Sunday"=>1}

    assert_equal days_hash, sales_analyst.invoice_count_per_day
  end

  def test_sales_analyst_calculates_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Thursday"], sales_analyst.top_days_by_invoice_count
  end

  def test_sales_analyst_calculates_invoices_status_percentages
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal Float, sales_analyst.invoice_status(:pending).class

    assert_equal 38.0, sales_analyst.invoice_status(:pending)
  end

  def test_sales_analyst_calculates_total_revenue_by_date
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 29776.22, sales_analyst.total_revenue_by_date(Time.parse("2012-02-26"))
  end

  def test_sales_analyst_calculates_total_revenue_by_date_zero_revenue
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 0.0, sales_analyst.total_revenue_by_date(Time.parse("2014-01-26"))
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_one
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Helm"], sales_analyst.top_revenue_earners(1).map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_multiple
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Helm", "Skype", "GoldenRayPress", "Johnson", "Lair"], sales_analyst.top_revenue_earners(5).map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_defaults_twenty
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Helm", "Skype", "GoldenRayPress", "Johnson", "Lair", "Bhyd", "Ello", "MiniatureBikez", "Candisart", "Hidy", "Urcase17", "Venmo", "GoldenHelmets", "Got"], sales_analyst.top_revenue_earners.map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_merchants_with_pending_invoices
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    require "pry"; binding.pry

    assert_equal ["MiniatureBikez", "GoldenHelmets", "Urcase17", "Venmo", "Skype", "Got"], sales_analyst.merchants_with_pending_invoices.map { |m| m.name }
  end
end
