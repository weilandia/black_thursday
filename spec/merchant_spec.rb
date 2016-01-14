require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class MerchantTest < Minitest::Test
  def setup
    @merchant = test_helper_merchant
  end

  def test_merchant_can_query_id
    assert_equal 12334105, @merchant.id
  end

  def test_merchant_can_query_name
    assert_equal "Shopin1901", @merchant.name
  end

  def test_merchant_can_query_creation_date
    assert_equal Time.new("2016-01-11 10:37:09 UTC"), @merchant.created_at
  end

  def test_merchant_can_query_date_of_last_update
    assert_equal Time.new("2016-01-11 10:37:09 UTC"), @merchant.updated_at
  end
end
