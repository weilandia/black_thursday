require 'csv'
require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_repo_can_list_all_merchants
    m = MerchantRepository.new

    merchant_one = Merchant.new(test_helper_merchant_one_data)
    merchant_two = Merchant.new(test_helper_merchant_two_data)
    merchant_three = Merchant.new(test_helper_merchant_three_data)

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two
    m.all_merchants << merchant_three

    assert_equal 3, m.all.length
    assert_equal Merchant, m.all.first.class
  end

  def test_merchant_repo_can_find_merchant_by_id
    m = MerchantRepository.new

    merchant_one = Merchant.new({id: 1})
    merchant_two = Merchant.new({id: 2})

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two

    assert_equal merchant_one, m.find_by_id(1)
    assert_equal merchant_two, m.find_by_id(2)
  end

  def test_merchant_repo_can_find_merchant_by_name
    m = MerchantRepository.new

    merchant_one = Merchant.new({name: "Penguin"})
    merchant_two = Merchant.new({name: "Random House"})

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two

    assert_equal merchant_one, m.find_by_name("Penguin")
    assert_equal merchant_two, m.find_by_name("Random House")
  end

  def test_merchant_repo_returns_error_message_when_search_not_found
    m = MerchantRepository.new

    merchant_one = Merchant.new({name: "Penguin"})
    merchant_two = Merchant.new({name: "Random House"})

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two

    assert_equal nil, m.find_by_name("House")
    assert_equal nil, m.find_by_name("Bird")
  end

  def test_merchant_repo_can_find_array_of_merchants_matching_search_fragment
    m = MerchantRepository.new

    merchant_one = Merchant.new({name: "Ven"})
    merchant_two = Merchant.new({name: "Venmo"})
    merchant_three = Merchant.new({name: "Myven"})
    merchant_four = Merchant.new({name: "Myv en"})

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two
    m.all_merchants << merchant_three
    m.all_merchants << merchant_four

    assert_equal [merchant_one, merchant_two, merchant_three], m.find_all_by_name("Ve")
  end

  def test_merchant_repo_name_fragment_search_is_case_insensitive
    m = MerchantRepository.new

    merchant_one = Merchant.new({name: "Ven"})
    merchant_two = Merchant.new({name: "Venmo"})
    merchant_three = Merchant.new({name: "Myven"})
    merchant_four = Merchant.new({name: "Myv en"})

    m.all_merchants << merchant_one
    m.all_merchants << merchant_two
    m.all_merchants << merchant_three
    m.all_merchants << merchant_four

    assert_equal [merchant_one, merchant_two, merchant_three], m.find_all_by_name("vEN")
  end
end
