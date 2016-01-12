require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    merchant_data = {:id => "12334105",
                :name => "Shopin1901",
                :created_at => "2016-01-11 10:37:09 UTC",
                :updated_at => "2016-01-11 10:37:09 UTC"
              }
    @merchant = Merchant.new(merchant_data)
  end

  def test_merchant_can_query_id
    assert_equal "12334105", @merchant.id
  end

  def test_merchant_can_query_name
    assert_equal "Shopin1901", @merchant.name
  end

  def test_merchant_can_query_creation_date
    assert_equal "2016-01-11 10:37:09 UTC", @merchant.created_at
  end

  def test_merchant_can_query_date_of_last_updated
    assert_equal "2016-01-11 10:37:09 UTC", @merchant.updated_at
  end
end
