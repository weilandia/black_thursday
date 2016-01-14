require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repo = test_helper_item_repo
  end

  def test_item_repo_queries_all_items
    items = CSV.open "./test_data/item_test.csv", headers: true, header_converters: :symbol
    assert_equal items.count, @item_repo.all.length
    assert_equal Array, @item_repo.all.class
    assert_equal Item, @item_repo.all[0].class
    assert_equal Item, @item_repo.all[1].class
    assert_equal Item, @item_repo.all[2].class
  end

  def test_item_repo_finds_item_by_id
    item = @item_repo.find_by_id(10)

    assert_equal Item, item.class

    assert_equal 10, item.id
  end

  def test_item_repo_finds_item_by_name
    item = @item_repo.find_by_name("Magnifique")

    assert_equal Item, item.class

    assert_equal "Magnifique", item.name
  end

  def test_item_repo_returns_message_when_search_not_found
    item_one = @item_repo.find_by_name("Turing")

    item_two = @item_repo.find_by_id("hello")

    assert_equal nil, item_one

    assert_equal nil, item_two
  end

  def test_item_repo_finds_array_of_items_matching_name_search_fragment
    search_array_names = @item_repo.find_all_by_name("Mag").map do |item|
      item.name
    end
    assert_equal ["Magnifique", "Very Magnifique"], search_array_names
  end

  def test_item_repo_name_fragment_search_is_case_insensitive
    search_array_names = @item_repo.find_all_by_name("mag").map do |item|
      item.name
    end
    assert_equal ["Magnifique", "Very Magnifique"], search_array_names
  end

  def test_item_repo_finds_array_of_items_matching_description_search_fragment
    search_array_description = @item_repo.find_all_with_description("decorative lighted").map do |item|
      item.name
    end
    assert_equal ["Shimmering Peacock"], search_array_description
  end

  def test_item_repo_finds_array_of_items_mathcing_price
    search_array_price = @item_repo.find_all_by_price(800.00).map do |item|
      item.name
    end
    assert_equal ["Very Magnifique", "TestItem28", "TestItem29"], search_array_price
  end

  def test_item_repo_finds_array_of_all_items_in_price_range
    search_array_price = @item_repo.find_all_by_price_in_range(750.0..850.0).map do |item|
      item.name
    end

    result = ["Very Magnifique", "TestItem28", "TestItem29"]

    assert_equal result, search_array_price
  end

  def test_item_repo_finds_array_of_all_items_given_merchant_id
    search_array = @item_repo.find_all_by_merchant_id(3).map do |item|
      item.name
    end
    assert_equal ["TestItem12", "TestItem35"], search_array
  end

end
