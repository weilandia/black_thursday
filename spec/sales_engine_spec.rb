require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_object_has_merchant_repository_object
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert_equal MerchantRepository, sales_engine.merchants.class
  end

  def test_sales_engine_object_has_item_repository_object
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert_equal ItemRepository, sales_engine.items.class
  end

  def test_sales_engine_object_has_invoice_repository_object
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert_equal InvoiceRepository, sales_engine.invoices.class
  end

  def test_sales_engine_data_files_hash_method_defaults_correct_files
    assert_equal SalesEngine.csv_data_files_hash[:merchants], "./data/merchants.csv"

    assert_equal SalesEngine.csv_data_files_hash[:items], "./data/items.csv"

    assert_equal SalesEngine.csv_data_files_hash[:invoices], "./data/invoices.csv"
  end

  # Integrated SalesEngine tests
  def test_sales_engine_object_has_access_to_merhant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.merchants.find_by_name("MiniatureBikez").id

    assert_equal 3, merchant_id
  end

  def test_sales_engine_object_has_access_to_merhant_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_name = sales_engine.merchants.find_by_id(3).name

    assert_equal "MiniatureBikez", merchant_name
  end

  def test_sales_engine_object_has_access_to_item_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_id = sales_engine.items.find_by_name("Very Magnifique").id

    assert_equal 2, item_id
  end

  def test_sales_engine_object_has_access_item_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_name = sales_engine.items.find_by_id(2).name

    assert_equal "Very Magnifique", item_name
  end

  def test_sales_engine_object_has_access_an_items_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_merchant_id = sales_engine.items.find_by_id(2).merchant_id

    assert_equal 1, item_merchant_id
  end

  def test_sales_engine_object_has_access_an_item_unit_price
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_unit_price = sales_engine.items.find_by_id(2).unit_price

    assert_equal 800.0, item_unit_price.to_f
  end

  def test_sales_engine_object_has_access_an_invoice_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice_id = sales_engine.invoices.find_by_id(2).id

    assert_equal 2, invoice_id
  end

  def test_sales_engine_object_has_access_an_invoice_customer_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    customer_id = sales_engine.invoices.find_by_id(4).customer_id

    assert_equal 1, customer_id
  end

  def test_sales_engine_object_has_access_an_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.invoices.find_by_id(20).merchant_id

    assert_equal 7, merchant_id
  end

  def test_sales_engine_object_has_access_an_invoice_status
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice_status = sales_engine.invoices.find_by_id(25).status

    assert_equal :returned, invoice_status
  end

  def test_sales_engine_creates_merchants_that_have_access_to_items
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant = sales_engine.merchants.find_by_id(1)
    assert_equal Array, merchant.items.class
    assert_equal 14, merchant.items.length
    assert_equal "Magnifique", merchant.items[0].name
    assert_equal "Very Magnifique", merchant.items[1].name
    assert_equal "Shimmering Peacock", merchant.items[2].name
    assert_equal "TestItem", merchant.items[3].name
  end

  def test_sales_engine_creates_merchants_that_have_access_to_invoices
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant = sales_engine.merchants.find_by_id(15)
    assert_equal Array, merchant.invoices.class
    assert_equal 8, merchant.invoices.length
    assert_equal 43, merchant.invoices[0].id
    assert_equal 44, merchant.invoices[1].id
  end

  def test_sales_engine_creates_items_that_have_access_to_merchants
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item = sales_engine.items.find_by_id(10)
    assert_equal Merchant, item.merchant.class
    assert_equal "Shopin1901", item.merchant.name
  end

  def test_sales_engine_creates_invoices_that_have_access_to_merchants
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice = sales_engine.invoices.find_by_id(18)
    assert_equal Merchant, invoice.merchant.class
    assert_equal "Urcase17", invoice.merchant.name
  end

  def test_sales_engine_object_has_access_to_invoice_object_items
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    items = sales_engine.invoices.all.first.items.map { |i| i.name}
    assert_equal ["TestItem18", "TestItem28", "TestItem1", "TestItem35", "TestItem26", "TestItem27", "TestItem16", "TestItem10"], items
  end

  def test_sales_engine_from_json
    sales_engine = SalesEngine.from_json(test_helper_csv_hash)
    assert_equal MerchantRepository, sales_engine.merchants.class
  end
end
