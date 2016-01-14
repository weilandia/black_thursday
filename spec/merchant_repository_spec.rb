require 'csv'
require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repo = test_helper_merchant_repo
  end

  def test_merchant_repo_can_list_all_merchants
    merchants = CSV.open "./test_data/merchant_test.csv", headers: true, header_converters: :symbol
    assert_equal merchants.count, @merchant_repo.all.length
    assert_equal Array, @merchant_repo.all.class
    assert_equal Merchant, @merchant_repo.all[0].class
    assert_equal Merchant, @merchant_repo.all[1].class
  end

  def test_merchant_repo_can_find_merchant_by_id
    merchant = @merchant_repo.find_by_id(3)
    assert_equal Merchant, merchant.class
    assert_equal 3, merchant.id
  end

  def test_merchant_repo_can_find_merchant_by_name
    merchant = @merchant_repo.find_by_name("MiniatureBikez")

    assert_equal Merchant, merchant.class

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_merchant_repo_returns_error_message_when_search_not_found
    merchant_one = @merchant_repo.find_by_name("Turing")

    merchant_two = @merchant_repo.find_by_id("hello")

    assert_equal nil, merchant_one

    assert_equal nil, merchant_two
  end

  def test_merchant_repo_can_find_array_of_merchants_matching_search_fragment
    search_array_names = @merchant_repo.find_all_by_name("Golden").map do |item|
      item.name
    end
    assert_equal ["GoldenRayPress", "GoldenHelmets"], search_array_names
  end

  def test_merchant_repo_name_fragment_search_is_case_insensitive
    search_array_names = @merchant_repo.find_all_by_name("gOlDeN").map do |item|
      item.name
    end
    assert_equal ["GoldenRayPress", "GoldenHelmets"], search_array_names
  end
end
