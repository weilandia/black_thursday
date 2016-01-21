require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_anaylst_calculates_merchants_with_one_item
    sales_engine = SalesEngine.new(
      merchants:  [
        {id: 1},
        {id: 2}
      ],
      items: [
        {id: 1, merchant_id: 1},
        {id: 2, merchant_id: 2},
        {id: 3, merchant_id: 2}
      ],
    )
    assert_equal [1], SalesAnalyst
                    .new(sales_engine)
                    .merchants_with_only_one_item
                    .map(&:id)
  end

  def test_sales_anaylst_identifies_merchants_with_one_item_registered_in_month
    sales_engine = SalesEngine.new(
      merchants:  [
        {id: 1, created_at: "2012-12-27 14:54:09 UTC"},
        {id: 2, created_at: "2012-12-27 14:54:09 UTC"},
        {id: 3, created_at: "2012-12-27 14:54:09 UTC"}
      ],
      items: [
        {id: 1, merchant_id: 1},
        {id: 2, merchant_id: 1},
        {id: 3, merchant_id: 1},
        {id: 4, merchant_id: 2},
        {id: 5, merchant_id: 3},
        {id: 6, merchant_id: 1}
      ],
    )
    assert_equal Merchant, SalesAnalyst
                          .new(sales_engine)
                          .merchants_with_only_one_item_registered_in_month("december").first.class

    assert_equal [2, 3], SalesAnalyst
                         .new(sales_engine)
                         .merchants_with_only_one_item_registered_in_month("december").map(&:id)
  end

  def test_sales_anaylst_calculates_revenue_by_merchant_id
    sales_engine = SalesEngine.new(
      merchants: [{id: 1}],
      invoices:  [
        {id: 1, merchant_id: 1},
        {id: 2, merchant_id: 1},
        {id: 3, merchant_id: 1}
      ],
      invoice_items: [
        {id: 1, invoice_id: 1, quantity: 3, unit_price:  4000, item_id: 1},
        {id: 2, invoice_id: 2, quantity:  1, unit_price: 1000, item_id: 2},
        {id: 3, invoice_id: 3, quantity:  5, unit_price: 2000, item_id: 3}
      ],
      transactions: [
        {id: 1, invoice_id: 1, result: "success"},
        {id: 2, invoice_id: 2, result: "success"},
        {id: 3, invoice_id: 3, result: "failed"}
      ],
    )
    assert_equal 130.0, SalesAnalyst
                      .new(sales_engine)
                      .revenue_by_merchant(1)
  end

  def test_sales_analyst_calculates_most_sold_item_for_merchant
    sales_engine = SalesEngine.new(
      merchants: [{id: 1}],
      invoices:  [{id: 1, merchant_id: 1}, {id: 2, merchant_id: 1}, {id: 3, merchant_id: 1}],
      invoice_items: [
        {id: 1, invoice_id: 1, quantity: 3, unit_price:  4000, item_id: 1},
        {id: 2, invoice_id: 2, quantity:  2, unit_price: 50000, item_id: 2}, {id: 3, invoice_id: 3, quantity:  30, unit_price: 2000, item_id: 3}
      ],
      items: [
        {id: 1, unit_price:  4000, merchant_id: 1},
        {id: 2, unit_price: 50000, merchant_id: 1},
        {id: 3, unit_price: 2000, merchant_id: 1}
      ],
      transactions: [
        {id: 1, invoice_id: 1, result: "success"},
        {id: 2, invoice_id: 2, result: "success"},
        {id: 3, invoice_id: 3, result: "failed"}
      ],
    )
    assert_equal 1, SalesAnalyst
                      .new(sales_engine)
                      .most_sold_item_for_merchant(1).first
                      .id
  end

  def test_sales_analyst_calculates_best_item_for_merchant
    sales_engine = SalesEngine.new(
      merchants: [{id: 1}],
      invoices:  [{id: 1, merchant_id: 1}, {id: 2, merchant_id: 1}, {id: 3, merchant_id: 1}],
      invoice_items: [
        {id: 1, invoice_id: 1, quantity: 3, unit_price:  4000, item_id: 1},
        {id: 2, invoice_id: 2, quantity:  10, unit_price: 50000, item_id: 2}, {id: 3, invoice_id: 3, quantity:  5, unit_price: 2000, item_id: 3}
      ],
      items: [
        {id: 1, unit_price:  4000, merchant_id: 1},
        {id: 2, unit_price: 50000, merchant_id: 1},
        {id: 3, unit_price: 2000, merchant_id: 1}
      ],
      transactions: [
        {id: 1, invoice_id: 1, result: "success"},
        {id: 2, invoice_id: 2, result: "success"},
        {id: 3, invoice_id: 3, result: "failed"}
      ],
    )
    assert_equal 2, SalesAnalyst
                      .new(sales_engine)
                      .best_item_for_merchant(1)
                      .id
  end

  def test_sales_analyst_calculates_best_item_for_merchant_with_quant
    sales_engine = SalesEngine.new(
      merchants: [{id: 1}],
      invoices:  [{id: 1, merchant_id: 1}, {id: 2, merchant_id: 1}],
      invoice_items: [
        {id: 1, invoice_id: 1, quantity: 20, unit_price:  4000, item_id: 1},
        {id: 2, invoice_id: 2, quantity:  1, unit_price: 50000, item_id: 2},
      ],
      items: [
        {id: 1, unit_price:  4_000, merchant_id: 1},
        {id: 2, unit_price: 50_000, merchant_id: 1},
      ],
      transactions: [
        {id: 1, invoice_id: 1, result: "success"},
        {id: 2, invoice_id: 2, result: "success"},
      ],
    )
    assert_equal 1, SalesAnalyst
                      .new(sales_engine)
                      .best_item_for_merchant(1)
                      .id
  end

  def test_sales_analyst_ranks_merchants_by_revenue
    sales_engine = SalesEngine.new(
      merchants: [{id: 1}, {id: 2}, {id: 3}],
      invoices:  [{id: 1, merchant_id: 1}, {id: 2, merchant_id: 2}, {id: 3, merchant_id: 3}],
      invoice_items: [
        {id: 1, invoice_id: 1, quantity: 1, unit_price:  50000},
        {id: 2, invoice_id: 2, quantity:  1, unit_price: 60000},
        {id: 3, invoice_id: 3, quantity:  1, unit_price: 70000}
      ],
      transactions: [
        {id: 1, invoice_id: 1, result: "success"},
        {id: 2, invoice_id: 2, result: "success"},
        {id: 3, invoice_id: 3, result: "success"}
      ],
    )
    assert_equal [3, 2, 1], SalesAnalyst
                            .new(sales_engine)
                            .merchants_ranked_by_revenue
                            .map(&:id)
  end

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

    assert_equal 29776.22, sales_analyst.total_revenue_by_date(Time.parse("2012-02-26")).to_f
  end

  def test_sales_analyst_calculates_total_revenue_by_date_zero_revenue
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 0.0, sales_analyst.total_revenue_by_date(Time.parse("2014-01-26"))
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_one
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Got"], sales_analyst.top_revenue_earners(1).map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_multiple
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Got", "GoldenHelmets", "Venmo", "Urcase17", "Hidy"], sales_analyst.top_revenue_earners(5).map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_top_revenue_merchants_defaults_twenty
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal ["Got", "GoldenHelmets", "Venmo", "Urcase17", "Hidy", "Candisart", "MiniatureBikez", "Ello", "Bhyd", "Lair", "Johnson", "GoldenRayPress", "Skype", "Helm"], sales_analyst.top_revenue_earners.map { |m| m.name }
  end

  def test_sales_anaylst_calculates_array_of_merchants_with_pending_invoices
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal ["Got"], sales_analyst.merchants_with_pending_invoices.map { |m| m.name }
  end

  def test_sales_anaylst_integration_calculates_best_item_for_merchant_nil
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal nil, sales_analyst.most_sold_item_for_merchant(1)
  end

  def test_sales_anaylst_integration_calculates_best_item_for_merchant
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal "TestItem1", sales_analyst.best_item_for_merchant(15).name
  end

  def test_sales_anaylst_integration_calculates_best_item_for_merchant_nil
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal nil, sales_analyst.best_item_for_merchant(1)
  end

  def test_sales_anaylst_integration_identifies_merchants_with_one_item_registered_month
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal [6], sales_analyst.merchants_with_only_one_item_registered_in_month("june").map { |m| m.id }
  end

  def test_sales_anaylst_integration_calculates_merchants_with_one_item
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], sales_analyst.merchants_with_only_one_item.map { |m| m.id }
  end

  # def test_sales_analyst_creates_graphs
  #   sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
  #   sales_analyst = SalesAnalyst.new(sales_engine)
  #   sales_analyst.g_merchant_rev
  #   sales_analyst.g_merchants_with_pending_invs
  #
  #   assert File.exist?('./graphs/all_merchants_by_revenue')
  #   assert File.exist?('./graphs/merchants_with_pending_invoices')
  # end
end
