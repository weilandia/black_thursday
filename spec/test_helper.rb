require 'minitest/autorun'
require 'minitest/pride'
require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'
require 'bigdecimal'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start

def test_helper_item_one_data
  {:id => "1",
  :name => "Item 1",
  :description => "Item One Description",
  :unit_price => "99999",
  :merchant_id => "1",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def test_helper_item_two_data
  {:id => "2",
  :name => "Item 2",
  :description => "Item Two Description",
  :unit_price => "9999",
  :merchant_id => "2",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def test_helper_item_three_data
  {:id => "3",
  :name => "Item 3",
  :description => "Item Three Description",
  :unit_price => "999",
  :merchant_id => "3",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def test_helper_merchant_one_data
  {:id => "1",
    :name => "Merchant One",
    :created_at => "2016-01-11 10:37:09 UTC",
    :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_merchant_two_data
  {:id => "2",
    :name => "Merchant Two",
    :created_at => "2016-01-11 10:37:09 UTC",
    :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_merchant_three_data
  {:id => "3",
    :name => "Merchant Three",
    :created_at => "2016-01-11 10:37:09 UTC",
    :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_one_data
  {:id => "1",
  :customer_id => "1",
  :merchant_id => "1",
  :status => :pending,
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_two_data
  {:id => "2",
  :customer_id => "2",
  :merchant_id => "2",
  :status => :shipped,
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_three_data
  {:id => "3",
  :customer_id => "3",
  :merchant_id => "3",
  :status => :returned,
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_item_one_data
  {:id => "1",
  :item_id => "1",
  :invoice_id => "1",
  :quantity => "1",
  :unit_price => "10000",
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_item_two_data
  {:id => "2",
  :item_id => "2",
  :invoice_id => "2",
  :quantity => "2",
  :unit_price => "20000",
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_invoice_item_three_data
  {:id => "3",
  :item_id => "3",
  :invoice_id => "3",
  :quantity => "3",
  :unit_price => "30000",
  :created_at => "2016-01-11 10:37:09 UTC",
  :updated_at => "2016-01-11 10:37:09 UTC"}
end

def test_helper_transaction_one_data
  {:id => "1",
  :invoice_id => "1",
  :credit_card_expiration_date => "1111",
  :credit_card_number => "1111111111111111",
  :result => "success",
  :created_at => "2012-02-26 20:56:56 UTC",
  :updated_at => "2012-02-26 20:56:56 UTC"}
end

def test_helper_transaction_two_data
  {:id => "2",
  :invoice_id => "2",
  :credit_card_expiration_date => "2222",
  :credit_card_number => "2222222222222222",
  :result => "failed",
  :created_at => "2012-02-26 20:56:56 UTC",
  :updated_at => "2012-02-26 20:56:56 UTC"}
end

def test_helper_transaction_three_data
  {:id => "3",
  :invoice_id => "3",
  :credit_card_expiration_date => "3333",
  :credit_card_number => "3333333333333333",
  :result => "success",
  :created_at => "2012-02-26 20:56:56 UTC",
  :updated_at => "2012-02-26 20:56:56 UTC"}
end

def test_helper_customer_one_data
  {:id => "1",
    :first_name => "One",
    :last_name => "Uno",
    :created_at => "2012-03-27 14:54:09 UTC",
    :updated_at => "2012-03-27 14:54:09 UTC"}
end

def test_helper_customer_two_data
  {:id => "2",
    :first_name => "Two",
    :last_name => "Dos",
    :created_at => "2012-03-27 14:54:09 UTC",
    :updated_at => "2012-03-27 14:54:09 UTC"}
end

def test_helper_customer_three_data
  {:id => "3",
    :first_name => "Three",
    :last_name => "Tres",
    :created_at => "2012-03-27 14:54:09 UTC",
    :updated_at => "2012-03-27 14:54:09 UTC"}
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

def test_helper_csv_hash
  {:merchants => "./test_data/merchant_test.csv",
  :items => "./test_data/item_test.csv",
  :invoices => "test_data/invoice_test.csv",
  :invoice_items => "./test_data/invoice_item_test.csv",
  :transactions => "./test_data/transaction_test.csv",
  :customers => "test_data/customer_test.csv"}
end

def test_helper_json_hash
  {:merchants => "./test_data/merchant_test.json",
  :items => "./test_data/item_test.json",
  :invoices => "test_data/invoice_test.json",
  :invoice_items => "./test_data/invoice_item_test.json",
  :transactions => "./test_data/transaction_test.json",
  :customers => "test_data/customer_test.json"}
end

def test_helper_json_sales_engine
  SalesEngine.new(test_helper_json_hash, :json)
end
