require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_customer_repo_can_list_all_customers
    c = CustomerRepository.new

    customer_one = Customer.new(test_helper_customer_one_data)
    customer_two = Customer.new(test_helper_customer_two_data)
    customer_three = Customer.new(test_helper_customer_three_data)

    c.all_customers << customer_one
    c.all_customers << customer_two
    c.all_customers << customer_three

    assert_equal 3, c.all.length
    assert_equal Customer, c.all.first.class
  end

  def test_customer_repo_can_find_customer_by_id
    customer_repo = CustomerRepository.new

    customer_one = Customer.new({id: 1, first_name: "Josh"})
    customer_two = Customer.new({id: 2, first_name: "Holly"})

    customer_repo.all_customers << customer_one
    customer_repo.all_customers << customer_two

    assert_equal customer_one, customer_repo.find_by_id(1)
    assert_equal customer_two.first_name, customer_repo.find_by_id(2).first_name
  end

  def test_customer_repo_can_find_all_customers_by_first_name
    customer_repo = CustomerRepository.new

    customer_one = Customer.new({id: 1, first_name: "Holly"})
    customer_two = Customer.new({id: 2, first_name: "Holly"})
    customer_three = Customer.new({id: 3, first_name: "Hollie"})

    customer_repo.all_customers << customer_one
    customer_repo.all_customers << customer_two
    customer_repo.all_customers << customer_three

    customers = customer_repo.find_all_by_first_name("Holly")

    assert_equal [customer_one, customer_two], customers
  end

  def test_customer_repo_can_find_all_customers_by_last_name
    customer_repo = CustomerRepository.new

    customer_one = Customer.new({id: 1, last_name: "Hemingway"})
    customer_two = Customer.new({id: 2, last_name: "Hemingway"})
    customer_three = Customer.new({id: 3, last_name: "Eliot"})

    customer_repo.all_customers << customer_one
    customer_repo.all_customers << customer_two
    customer_repo.all_customers << customer_three

    customers = customer_repo.find_all_by_last_name("Hemingway")

    assert_equal [customer_one, customer_two], customers
  end
end
