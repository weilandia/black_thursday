require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repo = MerchantRepository.new("test_data/merchant_test.csv")
  end

  def test_merchant_repo_can_list_all_merchants
    assert_equal 10, @merchant_repo.all.length
    assert_equal Array, @merchant_repo.all.class
    assert_equal Merchant, @merchant_repo.all[0].class
    assert_equal Merchant, @merchant_repo.all[1].class
    assert_equal Merchant, @merchant_repo.all[9].class
    assert_equal NilClass, @merchant_repo.all[10].class
  end

  def test_merchant_repo_can_find_merchant_by_id
    merchant = @merchant_repo.find_by_id(12334112)
    assert_equal Merchant, merchant.class
    assert_equal "12334112", merchant.id
  end

  def test_merchant_repo_can_find_merchant_by_name
    merchant = @merchant_repo.find_by_name("MiniatureBikez")

    assert_equal Merchant, merchant.class

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_merchant_repo_returns_error_message_when_search_not_found
    merchant_one = @merchant_repo.find_by_name("Turing")

    merchant_two = @merchant_repo.find_by_id("hello")

    assert_equal "Merchant not found.", merchant_one

    assert_equal "Merchant not found.", merchant_two
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
