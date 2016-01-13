def test_helper_item_one_data
  {:id => "0001",
  :name => "Test Item 1",
  :description => "This is our first test item!",
  :unit_price => "999",
  :merchant_id => "12334105",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def test_helper_item_two_data
  {:id => "0002",
  :name => "Test Item 2",
  :description => "This is our second test item!",
  :unit_price => "11111",
  :merchant_id => "12334105",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def test_helper_item_three_data
  {:id => "0003",
  :name => "Test Item 3",
  :description => "This is our third test item!",
  :unit_price => "33333",
  :merchant_id => "12334105",
  :created_at => "2016-01-11 12:22:31 UTC",
  :updated_at => "2012-03-27 14:53:59 UTC"
  }
end

def merchant_data
  {:id => "12334105",
    :name => "Shopin1901",
    :created_at => "2016-01-11 10:37:09 UTC",
    :updated_at => "2016-01-11 10:37:09 UTC"
  }
end

def test_helper_merchant
  Merchant.new(merchant_data)
end

def test_helper_item_repo
  ItemRepository.new("test_data/item_test.csv")
end

def test_helper_merchant_repo
  MerchantRepository.new("test_data/merchant_test.csv")
end

def load_merchant(item)
  item.load_merchant(merchant)
end

def test_helper_csv_hash
  {:merchants => "./test_data/merchant_test.csv",
  :items => "./test_data/item_test.csv"
  }
end
