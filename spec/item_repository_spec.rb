require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repo = ItemRepository.new("test_data/item_test.csv")
  end

  def test_item_repo_queries_all_items
    assert_equal 3, @item_repo.all.length
    assert_equal Array, @item_repo.all.class
    assert_equal Item, @item_repo.all[0].class
    assert_equal Item, @item_repo.all[1].class
    assert_equal Item, @item_repo.all[2].class
    assert_equal NilClass, @item_repo.all[3].class
  end

  def test_item_repo_finds_item_by_id
    item = @item_repo.find_by_id(263406193)

    assert_equal Item, item.class

    assert_equal "263406193", item.id
  end

  def test_item_repo_finds_item_by_name
    item = @item_repo.find_by_name("Magnifique")

    assert_equal Item, item.class

    assert_equal "Magnifique", item.name
  end

  def test_item_repo_returns_message_when_search_not_found
    item_one = @item_repo.find_by_name("Turing")

    item_two = @item_repo.find_by_id("hello")

    assert_equal "Item not found.", item_one

    assert_equal "Item not found.", item_two
  end

  def test_item_repo_finds_array_of_items_matching_search_fragment
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
end
