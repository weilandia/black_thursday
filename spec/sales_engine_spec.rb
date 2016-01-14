require 'minitest/autorun'
require 'minitest/pride'
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
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    assert_equal SalesEngine.data_files_hash[:merchants], "./data/merchants.csv"

    assert_equal SalesEngine.data_files_hash[:items], "./data/items.csv"

    assert_equal SalesEngine.data_files_hash[:invoices], "./data/invoices.csv"
  end

  # Integrated SalesEngine tests
  def test_sales_engine_object_has_access_to_merhant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.merchants.find_by_name("MiniatureBikez").id

    assert_equal 12334113, merchant_id
  end

  def test_sales_engine_object_has_access_to_merhant_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_name = sales_engine.merchants.find_by_id(12334113).name

    assert_equal "MiniatureBikez", merchant_name
  end

  def test_sales_engine_object_has_access_to_item_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_id = sales_engine.items.find_by_name("Very Magnifique").id

    assert_equal 263404435, item_id
  end

  def test_sales_engine_object_has_access_item_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_name = sales_engine.items.find_by_id(263404435).name

    assert_equal "Very Magnifique", item_name
  end

  def test_sales_engine_object_has_access_an_items_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_merchant_id = sales_engine.items.find_by_id(263404435).merchant_id

    assert_equal 12334144, item_merchant_id
  end

  def test_sales_engine_object_has_access_an_item_unit_price
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_unit_price = sales_engine.items.find_by_id(263404435).unit_price

    assert_equal 800.0, item_unit_price.to_f
  end

  def test_sales_engine_object_has_access_an_invoice_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice_id = sales_engine.invoices.find_by_id(4).id

    assert_equal 4, invoice_id
  end

  def test_sales_engine_object_has_access_an_invoice_customer_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    customer_id = sales_engine.invoices.find_by_id(4).customer_id

    assert_equal 1, customer_id
  end

  def test_sales_engine_object_has_access_an_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.invoices.find_by_id(20).merchant_id

    assert_equal 12336163, merchant_id
  end

  def test_sales_engine_object_has_access_an_invoice_status
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice_status = sales_engine.invoices.find_by_id(25).status

    assert_equal "returned", invoice_status
  end

  def test_sales_engine_creates_merchants_that_have_access_to_items
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant = sales_engine.merchants.find_by_id(12334105)
    assert_equal Array, merchant.items.class
    assert_equal 6, merchant.items.length
    assert_equal "TestItemOne", merchant.items[0].name
    assert_equal "TestItemTwo", merchant.items[1].name
    assert_equal "TestItemThree", merchant.items[2].name
    assert_equal "SalesAnalystItemZero", merchant.items[3].name
  end

  def test_sales_engine_creates_merchants_that_have_access_to_invoices
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant = sales_engine.merchants.find_by_id(12334112)
    assert_equal Array, merchant.invoices.class
    assert_equal 2, merchant.invoices.length
    assert_equal 10, merchant.invoices[0].id
    assert_equal 18, merchant.invoices[1].id
  end

  def test_sales_engine_creates_items_that_have_access_to_merchants
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item = sales_engine.items.find_by_id(1000)
    assert_equal Merchant, item.merchant.class
    assert_equal "Shopin1901", item.merchant.name
  end

  def test_sales_engine_creates_invoices_that_have_access_to_merchants
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice = sales_engine.invoices.find_by_id(18)
    assert_equal Merchant, invoice.merchant.class
    assert_equal "Candisart", invoice.merchant.name
  end
end
