require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/data_parser'

class ItemRepositoryTest < Minitest::Test
  def test_item_repo_queries_all_items
    i = ItemRepository.new

    item_one = Item.new(test_helper_item_one_data)
    item_two = Item.new(test_helper_item_two_data)
    item_three = Item.new(test_helper_item_three_data)

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three

    assert_equal 3, i.all.length
    assert_equal Item, i.all.first.class
  end

  def test_item_repo_finds_item_by_id
    i = ItemRepository.new

    item_one = Item.new({id: 1})
    item_two = Item.new({id: 2})

    i.all_items << item_one
    i.all_items << item_two

    assert_equal item_one, i.find_by_id(1)
    assert_equal item_two, i.find_by_id(2)
  end

  def test_item_repo_finds_item_by_name
    i = ItemRepository.new

    item_one = Item.new({name: "Book"})
    item_two = Item.new({name: "eBook"})

    i.all_items << item_one
    i.all_items << item_two

    assert_equal item_one, i.find_by_name("Book")
    assert_equal item_one, i.find_by_name("bOOK")
    assert_equal item_two, i.find_by_name("eBook")
  end

  def test_item_repo_returns_message_when_search_not_found
    i = ItemRepository.new

    item_one = Item.new({name: "Book"})
    item_two = Item.new({name: "eBook"})

    i.all_items << item_one
    i.all_items << item_two

    assert_equal nil, i.find_by_name("Newspaper")
  end

  def test_item_repo_finds_array_of_items_matching_name_search_fragment
    i = ItemRepository.new

    item_one = Item.new({name: "Ven"})
    item_two = Item.new({name: "Venmo"})
    item_three = Item.new({name: "Myven"})
    item_four = Item.new({name: "Myv en"})

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three
    i.all_items << item_four

    assert_equal [item_one, item_two, item_three], i.find_all_by_name("Ve")
  end

  def test_item_repo_name_fragment_search_is_case_insensitive
    i = ItemRepository.new

    item_one = Item.new({name: "Ven"})
    item_two = Item.new({name: "Venmo"})
    item_three = Item.new({name: "Myven"})
    item_four = Item.new({name: "Myv en"})

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three
    i.all_items << item_four

    assert_equal [item_one, item_two, item_three], i.find_all_by_name("Ve")
  end

  def test_item_repo_finds_array_of_items_matching_description_search_fragment
    i = ItemRepository.new

    item_one = Item.new({name: "Book", description: "You read it."})
    item_two = Item.new({name: "eBook", description: "A book, without paper. Read it!"})

    i.all_items << item_one
    i.all_items << item_two

    assert_equal [item_one, item_two], i.find_all_with_description("read")
    assert_equal [item_one], i.find_all_with_description("yoU")
  end

  def test_item_repo_finds_array_of_items_mathcing_price
    i = ItemRepository.new

    item_one = Item.new({unit_price: 8000})
    item_two = Item.new({unit_price: 7000})
    item_three = Item.new({unit_price: 8000})

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three

    assert_equal [item_one, item_three], i.find_all_by_price(8000)
    assert_equal [item_two], i.find_all_by_price(7000)
  end

  def test_item_repo_finds_array_of_all_items_in_price_range
    i = ItemRepository.new

    item_one = Item.new({unit_price: 8000})
    item_two = Item.new({unit_price: 7000})
    item_three = Item.new({unit_price: 8000})

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three

    assert_equal [item_one, item_two, item_three], i.find_all_by_price_in_range(6500..8500)
    assert_equal [item_two], i.find_all_by_price_in_range(6500..7500)
  end

  def test_item_repo_finds_array_of_all_items_given_merchant_id
    i = ItemRepository.new

    item_one = Item.new({id: 1, merchant_id: 1})
    item_two = Item.new({id: 2,  merchant_id: 1})
    item_three = Item.new({id: 3,  merchant_id: 2})

    i.all_items << item_one
    i.all_items << item_two
    i.all_items << item_three

    assert_equal [item_one, item_two], i.find_all_by_merchant_id(1)
    assert_equal [item_three], i.find_all_by_merchant_id(2)
  end

end
