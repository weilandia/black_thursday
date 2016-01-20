require 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class MerchantTest < Minitest::Test
  def test_merchant_can_query_id
    merchant = Merchant.new(test_helper_merchant_one_data)
    assert_equal 1, merchant.id
  end

  def test_merchant_can_query_name
    merchant = Merchant.new(test_helper_merchant_two_data)
    assert_equal "Merchant Two", merchant.name
  end

  def test_merchant_can_query_creation_date
    merchant = Merchant.new(test_helper_merchant_three_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), merchant.created_at
  end

  def test_merchant_can_query_date_of_last_update
    merchant = Merchant.new(test_helper_merchant_one_data)
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), merchant.updated_at
  end

  def test_merchant_can_query_revenue
    merchant = Merchant.new({id: 1})
    merchant.revenue = 4
    assert_equal 4, merchant.revenue
  end
end
