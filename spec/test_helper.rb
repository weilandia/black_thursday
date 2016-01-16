require 'minitest/autorun'; require 'minitest/pride'
require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'
require 'bigdecimal'

# class Minitest::Test
#   def setup
#     super
#     p location
#   end
# end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start

def test_helper_item_one_data
  {:id => 1,
  :name => "Test Item 1",
  :description => "This is our first test item!",
  :unit_price => "999",
  :merchant_id => "12334105",
  :created_at => Time.parse("2016-01-11 12:22:31 UTC"),
  :updated_at => Time.parse("2012-03-27 14:53:59 UTC")
  }
end

def test_helper_item_two_data
  {:id => 2,
  :name => "Test Item 2",
  :description => "This is our second test item!",
  :unit_price => "11111",
  :merchant_id => "12334105",
  :created_at => Time.parse("2016-01-11 12:22:31 UTC"),
  :updated_at => Time.parse("2012-03-27 14:53:59 UTC")
  }
end

def test_helper_item_three_data
  {:id => 3,
  :name => "Test Item 3",
  :description => "This is our third test item!",
  :unit_price => "33333",
  :merchant_id => "12334105",
  :created_at => Time.parse("2016-01-11 12:22:31 UTC"),
  :updated_at => Time.parse("2012-03-27 14:53:59 UTC")
  }
end

def merchant_data
  {:id => 12334105,
    :name => "Shopin1901",
    :created_at => Time.parse("2016-01-11 10:37:09 UTC"),
    :updated_at => Time.parse("2016-01-11 10:37:09 UTC")}
end

def invoice_data
  {:id => 11,
  :customer_id => "2",
  :merchant_id => "12334771",
  :status => :pending,
  :created_at => Time.parse("2016-01-11 10:37:09 UTC"),
  :updated_at => Time.parse("2016-01-11 10:37:09 UTC")}
end

def invoice_item_data
  {:id => 3,
  :item_id => "26351",
  :invoice_id => "12334771",
  :quantity => "8",
  :unit_price => "34873",
  :created_at => Time.parse("2016-01-11 10:37:09 UTC"),
  :updated_at => Time.parse("2016-01-11 10:37:09 UTC")}
end

def transaction_data
  {:id => 3,
  :invoice_id => "3",
  :credit_card_expiration_date => "1220",
  :credit_card_number => "4271810000000000",
  :result => "success",
  :created_at => Time.parse("2012-02-26 20:56:56 UTC"),
  :updated_at => Time.parse("2012-02-26 20:56:56 UTC")}
end

def customer_data
  {:id => 1,
    :first_name => "Joey",
    :last_name => "Ondricka",
    :created_at => Time.parse("2012-03-27 14:54:09 UTC"),
    :updated_at => Time.parse("2012-03-27 14:54:09 UTC")}
end


def test_helper_invoice_item
  InvoiceItem.new(invoice_item_data)
end

def test_helper_merchant
  Merchant.new(merchant_data)
end

def test_helper_invoice
  Invoice.new(invoice_data)
end

def test_helper_transaction
  Transaction.new(transaction_data)
end

def test_helper_customer
  Customer.new(customer_data)
end

def test_helper_item_repo
  item_repo = ItemRepository.new
  item_repo.from_csv("test_data/item_test.csv", item_repo)
  item_repo
end

def test_helper_merchant_repo
  merchant_repo = MerchantRepository.new
  merchant_repo.from_csv("test_data/merchant_test.csv", merchant_repo)
  merchant_repo
end

def test_helper_invoice_repo
  invoice_repo = InvoiceRepository.new
  invoice_repo.from_csv("test_data/invoice_test.csv", invoice_repo)
  invoice_repo
end

def test_helper_invoice_items_repo
  invoice_item_repo = InvoiceItemRepository.new
  invoice_item_repo.from_csv("test_data/invoice_item_test.csv", invoice_item_repo)
  invoice_item_repo
end

def test_helper_transaction_repo
  transaction_repo = TransactionRepository.new
  transaction_repo.from_csv("test_data/transaction_test.csv", transaction_repo)
  transaction_repo
end

def test_helper_customer_repo
  customer_repo = CustomerRepository.new
  customer_repo.from_csv("test_data/customer_test.csv", customer_repo)
  customer_repo
end

def test_helper_sales_engine
  SalesEngine.new(test_helper_csv_hash, :csv)
end

def test_helper_csv_hash
  {:merchants => "./test_data/merchant_test.csv",
  :items => "./test_data/item_test.csv",
  :invoices => "test_data/invoice_test.csv",
  :invoice_items => "./test_data/invoice_item_test.csv",
  :transactions => "./test_data/transaction_test.csv",
  :customers => "test_data/customer_test.csv"}
end

def test_helper_json_sales_engine
  SalesEngine.new(test_helper_csv_hash, :json)
end
