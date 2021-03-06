require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/data_parser'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_object_has_merchant_repository_object
    sales_engine = SalesEngine.new
    assert_equal MerchantRepository, sales_engine.merchants.class
  end

  def test_sales_engine_object_has_item_repository_object
    sales_engine = SalesEngine.new
    assert_equal ItemRepository, sales_engine.items.class
  end

  def test_sales_engine_object_has_customer_repository_object
    sales_engine = SalesEngine.new
    assert_equal CustomerRepository, sales_engine.customers.class
  end

  def test_sales_engine_object_has_invoice_item_repository_object
    sales_engine = SalesEngine.new
    assert_equal InvoiceItemRepository, sales_engine.invoice_items.class
  end

  def test_sales_engine_object_has_transaction_repository_object
    sales_engine = SalesEngine.new
    assert_equal TransactionRepository, sales_engine.transactions.class
  end

  # Integrated SalesEngine tests
  def test_sales_engine_object_can_access_merhant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.merchants.find_by_name("MiniatureBikez").id

    assert_equal 3, merchant_id
  end

  def test_sales_engine_object_can_access_merhant_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_name = sales_engine.merchants.find_by_id(3).name

    assert_equal "MiniatureBikez", merchant_name
  end

  def test_sales_engine_object_can_access_item_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_id = sales_engine.items.find_by_name("Very Magnifique").id

    assert_equal 2, item_id
  end

  def test_sales_engine_object_can_access_item_name
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_name = sales_engine.items.find_by_id(2).name

    assert_equal "Very Magnifique", item_name
  end

  def test_sales_engine_object_can_access_an_item_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item_merchant_id = sales_engine.items.find_by_id(2).merchant_id

    assert_equal 1, item_merchant_id
  end

  def test_sales_engine_object_can_access_an_item_unit_price
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    item = sales_engine.items.find_by_id(2)

    assert_equal 80000.0, item.unit_price
    assert_equal 800.00, item.unit_price_to_dollars
  end

  def test_sales_engine_object_can_access_an_invoice_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    invoice_id = sales_engine.invoices.find_by_id(2).id

    assert_equal 2, invoice_id
  end

  def test_sales_engine_object_can_access_an_invoice_customer_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    customer_id = sales_engine.invoices.find_by_id(4).customer_id

    assert_equal 1, customer_id
  end

  def test_sales_engine_object_can_access_an_invoice_merchant_id
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    merchant_id = sales_engine.invoices.find_by_id(20).merchant_id

    assert_equal 7, merchant_id
  end

  def test_sales_engine_object_can_access_an_invoice_status
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

  def test_sales_engine_object_has_access_to_invoice_object_transactions
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    transactions = sales_engine.invoices.all.first.transactions.map { |t| t.id}
    assert_equal [1], transactions
  end

  def test_sales_engine_object_has_access_to_invoice_object_transactions_multiple
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 5, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    transaction_one = Transaction.new({id: 1, invoice_id: 5, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    transaction_two = Transaction.new({id: 2, invoice_id: 5, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    transaction_three = Transaction.new({id: 3, invoice_id: 5, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    sales_engine.invoices.all << invoice
    sales_engine.transactions.all << transaction_one
    sales_engine.transactions.all << transaction_two
    sales_engine.transactions.all << transaction_three
    sales_engine.invoice_transaction_relationship
    transactions = sales_engine.invoices.all.first.transactions
    assert_equal [transaction_one, transaction_two, transaction_three], transactions
  end

  def test_sales_engine_object_has_access_to_invoice_object_customer
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 5, customer_id: 1, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    customer = Customer.new({id: 1, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    sales_engine.invoices.all << invoice
    sales_engine.customers.all << customer
    sales_engine.invoice_customer_relationship
    assert_equal customer, sales_engine.invoices.all.first.customer
  end

  def test_sales_engine_integration_object_has_access_to_invoice_object_transactions
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    customer = sales_engine.invoices.all.first.customer
    assert_equal 1, customer.id
  end

  def test_sales_engine_object_has_access_to_transaction_object_invoice
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 5, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    transaction = Transaction.new({id: 1, invoice_id: 5, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    sales_engine.invoices.all << invoice
    sales_engine.transactions.all << transaction
    sales_engine.transaction_invoice_relationship
    assert_equal invoice, sales_engine.transactions.all.first.invoice
  end

  def test_sales_engine_integration_object_has_access_to_transaction_object_invoice
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert_equal 1, sales_engine.transactions.all.first.invoice.id
  end

  def test_sales_engine_object_has_access_to_merchant_object_customers
    sales_engine = SalesEngine.new
    merchant = Merchant.new({id: 10, name: "Merch1", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    invoice_one = Invoice.new({id: 1, customer_id: 1, merchant_id: 10, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    customer_one = Customer.new({id: 1, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    invoice_two = Invoice.new({id: 2, customer_id: 2, merchant_id: 10, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    customer_two = Customer.new({id: 2, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    sales_engine.merchants.all << merchant
    sales_engine.invoices.all << invoice_one
    sales_engine.customers.all << customer_one
    sales_engine.invoices.all << invoice_two
    sales_engine.customers.all << customer_two
    sales_engine.merchant_customer_relationship
    customers = sales_engine.merchants.all.first.customers
    assert_equal [customer_one, customer_two], customers
  end

  def test_sales_engine_integration_object_has_access_to_merchant_object_customers
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert_equal [9, 10], sales_engine.merchants.all.last.customers.map {|c| c.id}
  end

  def test_sales_engine_object_has_access_to_customer_object_merchants
    sales_engine = SalesEngine.new
    merchant_one = Merchant.new({id: 10, name: "Merch1", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    merchant_two = Merchant.new({id: 20, name: "Merch2", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    invoice_one = Invoice.new({id: 1, customer_id: 1, merchant_id: 10, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    invoice_two = Invoice.new({id: 2, customer_id: 1, merchant_id: 20, status: "shipped", created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    customer = Customer.new({id: 1, created_at:"2016-01-11 11:44:13 UTC", updated_at:"2016-01-11 11:44:13 UTC"})
    sales_engine.merchants.all << merchant_one
    sales_engine.merchants.all << merchant_two
    sales_engine.invoices.all << invoice_one
    sales_engine.invoices.all << invoice_two
    sales_engine.customers.all << customer
    sales_engine.customer_merchant_relationship
    merchants = sales_engine.customers.all.first.merchants
    assert_equal [merchant_one, merchant_two], merchants
  end

  def test_sales_engine_can_assert_invoice_is_paid_in_full
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 1})
    transaction_one = Transaction.new({id:100, invoice_id: 1, result: "failed"})
    transaction_two = Transaction.new({id:200, invoice_id: 1, result: "success"})
    sales_engine.invoices.all << invoice
    sales_engine.transactions.all << transaction_one
    sales_engine.transactions.all << transaction_two
    sales_engine.relationships

    assert sales_engine.invoices.find_by_id(1).is_paid_in_full?
  end

  def test_sales_engine_can_refute_invoice_is_paid_in_full
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 1})
    transaction_one = Transaction.new({id:100, invoice_id: 1, result: "failed"})
    transaction_two = Transaction.new({id:200, invoice_id: 1, result: "failed"})
    sales_engine.invoices.all << invoice
    sales_engine.transactions.all << transaction_one
    sales_engine.transactions.all << transaction_two
    sales_engine.relationships
    refute sales_engine.invoices.find_by_id(1).is_paid_in_full?
  end

  def test_sales_engine_integration_can_assert_invoice_is_paid_in_full
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    assert sales_engine.invoices.find_by_id(2).is_paid_in_full?
  end

  def test_sales_engine_integration_can_refute_invoice_is_paid_in_full
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)
    refute sales_engine.invoices.find_by_id(48).is_paid_in_full?
  end

  def test_sales_engine_can_query_invoice_total
    sales_engine = SalesEngine.new
    invoice = Invoice.new({id: 1})
    invoice_item_one = InvoiceItem.new({id: 1, invoice_id: 1, unit_price: 5000, quantity: 2})
    invoice_item_two = InvoiceItem.new({id: 2, invoice_id: 1, unit_price: 2000, quantity: 5})
    sales_engine.invoices.all << invoice
    sales_engine.invoice_items.all << invoice_item_one
    sales_engine.invoice_items.all << invoice_item_two
    sales_engine.invoice_invoice_item_relationship

    assert_equal 200.00, sales_engine.invoices.find_by_id(1).total
    assert_equal BigDecimal, sales_engine.invoices.find_by_id(1).total.class
  end

  def test_sales_engine_integration_can_query_invoice_total
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    assert_equal 4036.08, sales_engine.invoices.find_by_id(9).total
    assert_equal 21067.77, sales_engine.invoices.find_by_id(1).total
    assert_equal 17022.32, sales_engine.invoices.find_by_id(7).total
  end

  def test_sales_engine_integration_merchant_can_query_revenue
    sales_engine = SalesEngine.from_csv(test_helper_csv_hash)

    assert_equal 80661.54, sales_engine.merchants.all.last.revenue.to_f
  end

  def test_sales_engine_can_read_from_json
    sales_engine = SalesEngine.from_json(test_helper_json_hash)
    assert_equal MerchantRepository, sales_engine.merchants.class
  end
end
