require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_customer_repo_can_list_all_customers
    customers = CSV.open "./test_data/customer_test.csv", headers: true, header_converters: :symbol
    customer_repo = test_helper_customer_repo
    assert_equal customers.count, customer_repo.all.length
    assert_equal Array, customer_repo.all.class
    assert_equal Customer, customer_repo.all[0].class
    assert_equal Customer, customer_repo.all[1].class
  end

  def test_customer_repo_can_find_customer_by_id
    customer_repo = test_helper_customer_repo
    customer = customer_repo.find_by_id(3)
    assert_equal Customer, customer.class
    assert_equal 3, customer.id
    assert_equal "Mariah", customer.first_name
  end

  def test_customer_repo_can_find_all_customers_by_first_name
    customer_repo = test_helper_customer_repo
    customers = customer_repo.find_all_by_first_name("Loyal")
    assert_equal Customer, customers.first.class
    assert_equal ["Loyal", "Loyal"], customers.map { |n| n.first_name }
  end

  def test_customer_repo_can_find_all_customers_by_last_name
    customer_repo = test_helper_customer_repo
    customers = customer_repo.find_all_by_last_name("Fadel")
    assert_equal Customer, customers.first.class
    assert_equal ["Fadel", "Fadel"], customers.map { |n| n.last_name }
  end
end
