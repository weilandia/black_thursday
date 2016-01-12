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
  Merchant.new(merchant_data, test_helper_item_repo)
end

def test_helper_item_repo
  ItemRepository.new("test_data/item_test.csv")
end

def test_helper_merchant_repo
  MerchantRepository.new("test_data/merchant_test.csv", test_helper_item_repo)
end

def load_merchant(item)
  item.load_merchant(merchant)
end

def test_helper_csv_hash
  {:merchants => "./test_data/merchant_test.csv",
  :items => "./test_data/item_test.csv"
  }
end

class TestMerchant
  attr_reader :id, :name, :created_at, :updated_at, :items
  def initialize
    @id="12334105"
    @name="Shopin1901"
    @updated_at="2016-01-11 10:37:09 UTC"
    @created_at="2016-01-11 10:37:09 UTC"
    @items=
      [TestItem.new("2016-01-11 10:37:09 UTC",
      "Vogue Paris",
      "263396209",
      "12334105",
      "Vogue Paris Original Givenchy 2307",
      "2999",
      "1995-03-19 10:02:43 UTC"),
      TestItem.new("2016-01-11 10:37:09 UTC",
      "Butterick 4236",
      "263500440",
      "12334105",
      "Butterick 4236 Bridal Accessories",
      "999",
      "1973-02-23 00:23:54 UTC")]
      $merchant = self
  end
end

class TestItem
  def initialize(created_at, description, id, merchant_id, name, unit_price, updated_at)
    @created_at = created_at
    @description = description
    @id = id
    @merchant_id = merchant_id
    @name = name
    @unit_price = unit_price
    @updated_at = updated_at
    @merchant =  $merchant
  end
end
